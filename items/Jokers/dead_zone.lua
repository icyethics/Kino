SMODS.Joker {
    key = "dead_zone",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            power_counters = 3,
            has_triggered = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 3, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11336,
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
    pools, k_genre = {"Horror", "Mystery", "Thriller"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.power_counters,
                localize(G.GAME.current_round.kino_dead_zone_hand or "High Card", 'poker_hands') 
            }
        }
    end,
    calculate = function(self, card, context)
        -- The first time each round
        -- Put 3 Power Counters on a random joker if you've played the given hand
        -- hand changes every round
        if context.first_hand_drawn then
            local eval = function() return not card.ability.extra.has_triggered and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.after and context.cardarea == G.jokers and 
        context.scoring_name == G.GAME.current_round.kino_dead_zone_hand
        and card.ability.extra.has_triggered == false then
            local _validtargets = {}
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker ~= card then
                    _validtargets[#_validtargets + 1] = _joker
                end
            end

            local _target = pseudorandom_element(_validtargets, pseudoseed("kino_deadzone"))

            if _target then
                card.ability.extra.has_triggered = true
                -- Kino.change_counters(_target, "kino_power", card.ability.extra.power_counters)
                _target:bb_counter_apply("counter_kino_power", card.ability.extra.power_counters)
            end
        end

        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.has_triggered = false
        end
    end
}