SMODS.Joker {
    key = "zoolander",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 2, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9398,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Spades held in hand give X1.5 steel
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}