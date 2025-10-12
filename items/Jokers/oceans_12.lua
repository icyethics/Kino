SMODS.Joker {
    key = "oceans_12",
    order = 268,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            steal_money = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 3, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 163,
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
    k_genre = {"Heist", "Crime", "Action"},
    enhancement_gate = 'm_kino_crime',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.steal_money
            }
        }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop then
            Kino:increase_money_stolen(card.ability.extra.steal_money)
        end
    end
}