SMODS.Joker {
    key = "rocky_1",
    order = 11,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 1 },
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1366,
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
    k_genre = {"Sports"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- upgrade hand if it's the final hand.
        if context.before and G.GAME.current_round.hands_left == 0 then
            return {
                card = card,
                level_up = true,
                message = localize('k_level_up_ex')
            }
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
        if args.type == 'kino_level_up_hand' then
            if to_big(G.GAME.hands["High Card"].level) >= to_big(9) then
                unlock_card(self)
            end
        end
    end,
}