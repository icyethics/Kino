SMODS.Joker {
    key = "shrek_1",
    order = 1000,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            

        }
    },
    rarity = 3,
    atlas = "kino_exotic",
    pos = { x = 0, y = 0},
    soul_pos = { x = 0, y = 2, extra = { x = 0, y = 1}},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 20048,
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
    poolss, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)

    end
}