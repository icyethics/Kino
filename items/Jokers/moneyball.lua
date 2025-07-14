SMODS.Joker {
    key = "moneyball",
    order = 154,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 60308,
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
    pools, k_genre = {"Sports", "Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)


        if context.after and context.cardarea == G.jokers then
            if to_big(G.GAME.current_round.hands_played) == to_big(0) then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or to_big(0)) + G.GAME.hands[context.scoring_name].level
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    dollars = to_number(G.GAME.hands[context.scoring_name].level)
                }
            end
        end
    end
}