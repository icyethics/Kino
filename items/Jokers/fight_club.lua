SMODS.Joker {
    key = "fight_club",
    order = 35,
    config = {
        extra = {
            xmult = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- x3, and destroy a random scored card.
        if context.joker_main then
            -- Select a random card
            
            local destroyed_card = pseudorandom_element(context.scoring_hand)
            SMODS.calculate_context({destroy_card = destroyed_card})

            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}