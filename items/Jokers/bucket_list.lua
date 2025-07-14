SMODS.Joker {
    key = "bucket_list",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 7350,
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
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        -- Starts with 3 charges
        -- When you have 0 hands left, but haven't won the round
        -- add 1 hand and consume 1 charge
        -- add 1 charge every 3 antes
        if context.after and context.cardarea == G.jokers and card.ability.extra.stacks then
            if G.GAME.current_round.hands_left == 0 then
                if to_big((hand_chips * mult)) < to_big(G.GAME.blind.chips) then
                    card.ability.extra.stacks = card.ability.extra.stacks - 1
                    ease_hands_played(1)
                end
            end
        end
    end
}