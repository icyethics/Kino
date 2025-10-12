SMODS.Joker {
    key = "catch_me_if_you_can",
    order = 96,
    config = {
        extra = {
            money = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 640,
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
    k_genre = {"Drama", "Crime"},
    enhancement_gate = "m_wild",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- Wild cards give $2 when scored

        if context.individual and context.cardarea == G.play and
        SMODS.has_enhancement(context.other_card, "m_wild") then
            return {
                dollars = card.ability.extra.money,
            }
        end
    end
}