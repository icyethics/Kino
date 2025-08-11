if Cryptid and Talisman then
    
SMODS.Joker {
    key = "shrek_1",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            triggers_non = 0,
            threshold_non = 3
        }
    },
    rarity = "cry_exotic",
    atlas = "kino_exotic",
    pos = { x = 0, y = 0},
    soul_pos = { x = 0, y = 2, extra = { x = 0, y = 1 } },
    cost = 50,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Animation", "Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- 
    end
}
end