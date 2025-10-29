SMODS.Joker {
    key = "sinners",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            blood_counters = 2,
            active = true
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 4, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1233413,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    k_genre = {"Horror"},
    is_vampire = true,
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.is_vampire then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1]  = {set = 'Other', key = "keyword_drain"}
        return {
            vars = {
                card.ability.extra.blood_counters
            }
        }
    end,
    calculate = function(self, card, context)
        -- Drain debuff the first scored card each round
        -- Put 2 blood counters on each card that shares its rank in your deck

        if context.first_hand_drawn then
            card.ability.extra.active = true
            local eval = function() return card.ability.extra.active and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.individual and context.cardarea == G.play and card.ability.extra.active then
            if Kino.drain_property(context.other_card, card, {Base = {debuff = "kino_drain"}}) then
                local _value = context.other_card:get_id()
                
                for _index, _pcard in ipairs(G.playing_cards) do
                    if _pcard:can_calculate() and _pcard:get_id() == _value and
                    _pcard ~= context.other_card then
                        _pcard:bb_counter_apply("counter_kino_blood", card.ability.extra.blood_counters)
                    end
                end
                card.ability.extra.active = false

                return {
                    message = localize("k_kino_sinners_blood"),
                    colour = G.C.KINO.DRAIN
                }
            end
        end
    end
}