SMODS.Joker {
    key = "war_of_the_worlds_2025",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            threshold = 2,
            money_per = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 1, y = 1},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 755898,
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
    k_genre = {"Sci-fi", "Thriller"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money_per
            }
        }
    end,
    calculate = function(self, card, context)
        -- It was YOU???
        -- They EAT data
        if context.setting_blind then
            local _hands = G.GAME.current_round.hands_left
            local _discards = G.GAME.current_round.discards_left

            local _hands_change = G.GAME.current_round.hands_left - card.ability.extra.threshold
            local _discards_change = G.GAME.current_round.discards_left - card.ability.extra.threshold
    
            local _money_earned = (_hands_change + _discards_change) * card.ability.extra.money_per

            G.E_MANAGER:add_event(Event({func = function()
                ease_discard(-_discards_change)
                ease_hands_played(-_hands_change)
                ease_dollars(_money_earned)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {-_hands_change}}})
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {-_discards_change}}})
            
            return true end }))
        end


    end
}