SMODS.Joker {
    key = "lord_of_the_rings_1",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 2,
            sell_value_loss_non = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 120,
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
    pools, k_genre = {"Fantasy", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.sell_value_loss_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- The joker to the right becomes the Ringbearer, and gives x2 mult when triggered
        -- At the end of the round, it loses $2 sell value. If it's sell value reaches 0,
        -- destroy it

        if context.post_trigger and context.cardarea == G.jokers
        and not context.other_context.post_trigger and
        not context.other_context.destroying_card and
        G.STATE == G.STATES.HAND_PLAYED then
            -- Find me
            local _mypos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    _mypos = i
                end
            end

            -- check if joker to the right
            if G.jokers.cards[_mypos + 1] and context.other_card == G.jokers.cards[_mypos + 1] then
                local _joker = G.jokers.cards[_mypos + 1]
                _joker.marked_by_lotr_1 = card.ID

                return {
                    card = _joker,
                    x_mult = card.ability.extra.x_mult
                }
            end
        end

        if context.end_of_round and context.cardarea == G.jokers then
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker.marked_by_lotr_1 == card.ID then
                    _joker.marked_by_lotr_1 = nil
                
                    _joker.ability.extra_value = _joker.ability.extra_value - card.ability.extra.sell_value_loss_non
                    _joker:set_cost()

                    if _joker.sell_cost <= 0 then
                        _joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({func = function()
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            _joker:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                end
            end
        end
    end
}