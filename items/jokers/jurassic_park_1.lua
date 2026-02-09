SMODS.Joker {
    key = "jurassic_park_1",
    order = 95,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            nominal_mult_factor = 5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 3},
    cost = 15,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 329,
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
    k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.nominal_mult_factor
            }
        }
    end,
    calculate = function(self, card, context)

    end
}