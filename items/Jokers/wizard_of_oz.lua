SMODS.Joker {
    key = "wizard_of_oz",
    order = 131,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 630,
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
    k_genre = {"Fantasy", "Musical"},
    enhancement_gate = "m_wild",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and 
        context.other_card.config.center == G.P_CENTERS.m_wild then
            return {
                x_mult = card.ability.extra.x_mult,
                card = context.other_card
            }
        end
    end
}