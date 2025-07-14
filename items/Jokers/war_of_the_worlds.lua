SMODS.Joker {
    key = "war_of_the_worlds",
    order = 156,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_hands = 1,
            a_discards = 1,
        }
    },
    rarity = 3,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 1},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 74,
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
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        -- local _keystring = "genre_" .. #self.k_genre
        -- info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.a_hands,
                card.ability.extra.a_discards
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local _planets_destroyed = 0
            local _hands = 0
            local _discards = 0

            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == "Planet" then
                    G.consumeables.cards[i].getting_sliced = true
                    G.consumeables.cards[i]:start_dissolve({G.C.BLACK}, nil, 1.6)
                    _planets_destroyed = _planets_destroyed + 1
                    if i % 2 == 1 then
                        _hands = _hands + 1
                    else 
                        _discards = _discards + 1
                    end
                end
            end

            G.E_MANAGER:add_event(Event({func = function()
                ease_discard(_discards)
                ease_hands_played(_hands)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {_hands}}})
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {_discards}}})
            return true end }))
        end
    end
}