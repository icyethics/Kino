SMODS.Joker {
    key = "rocket_man",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_stacks = 1,
            stacks = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 45612,
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
    pools, k_genre = {"Biopic", "Musical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- W
    end
}