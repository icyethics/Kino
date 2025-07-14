SMODS.Joker {
    key = "truman_show",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 1, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 37165,
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
    pools, k_genre = {"Drama", "Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain the current ratings as chips
        -- ratings go up when you do something flashy
        -- ratings go down when you do something boring
        
    end
}