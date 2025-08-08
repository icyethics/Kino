SMODS.Joker {
    key = "terminator_2",
    order = 61,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            affects_sci_fi = true,
            perma_x_mult = 0.1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 4},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 280,
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
    pools, k_genre = {"Sci-fi", "Action"},
    enhancement_gate = "m_kino_sci_fi",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When sci-fi cards upgrade, they gain x.1 mult instead
    end
}