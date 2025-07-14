SMODS.Joker {
    key = "12_monkeys",
    order = 163,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            current_target = nil,
            cur_chance = 1,
            chance = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_5",
    pos = { x = 4, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 63,
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
    pools, k_genre = {"Sci-fi", "Thriller"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.cur_chance, card.ability.extra.chance, "kino_card_creation") -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
        return {
            vars = {
                new_numerator,
                new_denominator,
                card.ability.extra.current_target and card.ability.extra.current_target.set or "???",
            }
        }
    end,
    calculate = function(self, card, context)
        -- 1/2 chance to create a copy of the first item you've sold since the last blind
        if context.selling_card and card.ability.extra.current_target == nil and not context.blueprint and not context.retrigger then
            card.ability.extra.current_target = {
               key = context.card.ability.key,
               cardarea = context.card.area,
               set = context.card.ability.set
            }
        end

        if context.setting_blind and
        card.ability.extra.current_target and
        SMODS.pseudorandom_probability(card, 'kino_12monk', card.ability.extra.cur_chance, card.ability.extra.chance, "kino_card_creation") then
            local _inf = card.ability.extra.current_target
            local _buffer = nil
            
            if _inf.cardarea == G.jokers then
                _buffer = G.GAME.joker_buffer
            else
                _buffer = G.GAME.consumeable_buffer
            end
            _buffer = _buffer + 1

            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    
                    local _card = create_card(_inf.set, _inf.cardarea, nil, nil, nil, nil, _inf.key, "monkeys")
                    _card:add_to_deck()
                    _inf.cardarea:emplace(_card)
                    _buffer = 0
                    card.ability.extra.current_target = nil
                    return true
                end)}))
        end
    end
}