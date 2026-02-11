SMODS.Joker {
    key = "john_wick_1",
    order = 286,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            bullets_created = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 3, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 245891,
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
    enhancement_gate = "m_kino_action",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bullets_created
            }
        }
    end,
    calculate = function(self, card, context)
        -- Create 2 bullets whenever a card is destroyed
        if context.remove_playing_cards then
            Kino.add_bullet(#context.removed * card.ability.extra.bullets_created)

            card:juice_up()
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_john_wick_unlock' then
            unlock_card(self)
        end
    end,
}

