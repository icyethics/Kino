SMODS.Joker {
    key = "fight_club",
    order = 35,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 550,
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
    k_genre = {"Thriller", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- x3, and destroy a random scored card. (Code by Eremel)
        if context.joker_main then
            -- Select a random card
            pseudorandom_element(context.scoring_hand).marked_to_destroy_by_fight_club = true
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.destroying_card and context.destroying_card.marked_to_destroy_by_fight_club then
            return { remove = true }
        end
    end
}