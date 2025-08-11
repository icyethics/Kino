SMODS.Joker {
    key = "oceans_11_2",
    order = 184,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            max_negative_value = -20,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 3, y = 0},
    cost = 10,
    blueprint_compat = false,
    perishable_compat = false,
    kino_joker = {
        id = 299,
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
    pools, k_genre = {"Heist", "Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.max_negative_value
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you spend money, regain that money and lower the value of this joker
        -- Reset sell value to 1 if debuffed

        if context.kino_ease_dollars and context.kino_ease_dollars < to_big(0) and not context.blueprint and not context.repetition then
            if card.sell_cost > card.ability.extra.max_negative_value then
                local _gains = -1 * context.kino_ease_dollars

                card.ability.extra_value = (card.ability.extra_value or 0) + context.kino_ease_dollars
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_ocean_11_2'), colour = G.C.MONEY })

                ease_dollars(_gains)
                card:set_cost()
            end
        end
    end
}