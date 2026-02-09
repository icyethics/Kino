SMODS.Joker {
    key = "sunshine",
    order = 309,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 2, y = 3},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1272,
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
    k_genre = {"Sci-fi", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Heart cards held in hand give +3 mult
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Hearts") then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}