SMODS.Joker {
    key = "dune_1984",
    order = 304,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            levels = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 841,
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
    pools, k_genre = {"Fantasy", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.levels
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play your least played hand, upgrade it twice
        if context.before then
            local _hands = get_least_played_hand()

            for _, _hand in ipairs(_hands) do
                if _hand == context.scoring_name then
                    return {
                        level_up = card.ability.extra.levels
                    }
                end
            end
        end
    end
}