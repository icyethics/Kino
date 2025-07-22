SMODS.Joker {
    key = "gravity",
    order = 222,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            level_up = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 5, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 49047,
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
    pools, k_genre = {"Drama", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.level_up
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you enter the blind with a planet in hand, upgrade a random hand

        if context.setting_blind then
            for _, _consumable in ipairs(G.consumeables.cards) do
                if _consumable.ability.set == "Planet" then
                    local _hand = get_random_hand()
                    -- level_up_hand
                    SMODS.smart_level_up_hand(card, _hand, nil, card.ability.extra.level_up)
                end
            end
        end
    end
}