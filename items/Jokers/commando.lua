SMODS.Joker {
    key = "commando",
    order = 179,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 4, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10999,
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
    enhancement_gate = 'm_wild',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- wild cards held in hand give +5 mult

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, "m_wild") and not context.other_card.debuffed then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
}