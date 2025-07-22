SMODS.Joker {
    key = "mars_attacks",
    order = 55,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            additional_levels = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 3},
    cost = 4,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 75,
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
    pools, k_genre = {"Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.additional_levels
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind, destroy every planet you have, then upgrade 4 of a kind for each planet destroyed.
        -- If Full House's level would go down to 0, LOSE THE GAME 
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == "Planet" and context.consumeable.ability.name == "Mars" then

                if G.GAME.hands["Full House"].level == 1 then
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_mars_attacks_2'), colour = G.C.MULT })

                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                        G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
                    return true end }))
                    
                end

                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_mars_attacks'), colour = G.C.CHIPS })

                -- level_up_hand
                SMODS.smart_level_up_hand(card, "Four of a Kind", nil, card.ability.extra.additional_levels)
                -- level_up_hand
                SMODS.smart_level_up_hand(card, "Full House", nil, -1)
                
                     
            end
        end
    end
}