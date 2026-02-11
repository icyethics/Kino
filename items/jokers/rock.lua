SMODS.Joker {
    key = "rock",
    order = 155,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9802,
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
    enhancement_gate = "m_stone",
    k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and  SMODS.has_enhancement(context.other_card, "m_stone") then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}