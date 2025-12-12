SMODS.Joker {
    key = "ed_wood",
    order = 54,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            blind_piece_non = 25,
            money = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 522,
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
    k_genre = {"Comedy", "Drama", "Biopic"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.blind_piece_non,
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- when your hand scored less than 1/4th of the blind,
        -- earn $3.
        if context.after and context.cardarea == G.jokers then
            if to_big((hand_chips * mult)) < to_big(G.GAME.blind.chips) * to_big(card.ability.extra.blind_piece_non / 100) then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    message = localize("$")..card.ability.extra.money,
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
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
        if args.type == 'win' then
            if to_big(G.GAME.dollars) <= to_big(0) then
                unlock_card(self)
            end
        end
    end,
}