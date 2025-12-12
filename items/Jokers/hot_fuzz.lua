SMODS.Joker {
    key = "hot_fuzz",
    order = 294,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            bullets_created = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 5, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 4638,
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
    k_genre = {"Comedy", "Action"},
    enhancement_gate = 'm_kino_action',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bullets_created
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a Pair, increase the bullet count of this card by 1. Resets when you play a high card
        if context.joker_main then
            if context.scoring_name == "Pair" then
                Kino.add_bullet(card.ability.extra.bullets_created)
                card:juice_up()
            end
        end
    end
}