SMODS.Joker {
    key = "karate_kid_1",
    order = 16,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            rank_1 = 14,
            rank_2 = 2,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 2},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1885,
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
    pools, k_genre = {"Sports"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.rank_1,
                card.ability.extra.rank_2
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local correct_ranks = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 or context.scoring_hand[i]:get_id() == 2 then
                    correct_ranks = correct_ranks + 1
                end
            end

            if correct_ranks >= 1 then
                local handtype = get_random_hand()
                -- level_up_hand
                SMODS.smart_level_up_hand(context.blueprint_card or card, handtype, nil, 1)
            end
        end
    end
}