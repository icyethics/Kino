SMODS.Joker {
    key = "6_underground",
    order = 162,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 6
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 509967,
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
    k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card:get_id() == 6 and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}