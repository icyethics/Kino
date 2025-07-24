SMODS.Enhancement {
    key = "horror",
    atlas = "kino_enhancements",
    pos = { x = 2, y = 0},
    config = {
        x_chips_return = 2,
        chance = 4

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.x_chips_return,
                G.GAME.probabilities.normal,
                card.ability.chance
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- When in hand, 1.5x chips, but 4/5 chance to turn into a monster card. 
        -- MONSTER Card: cannot be discarded. -50 chips 

        --G.FUNCS.can_discard = function(e)
        if context.main_scoring and context.cardarea == G.hand then
            if pseudorandom("m_horror") < G.GAME.probabilities.normal / card.ability.chance then
                -- Change into monster card
                G.GAME.current_round.horror_transform = G.GAME.current_round.horror_transform + 1
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_monster_turn'), colour = G.C.BLACK })
                card:set_ability(G.P_CENTERS.m_kino_monster, nil, true)
                SMODS.calculate_context({monster_awaken = true})

                if next(find_joker("j_kino_wolf_man_1")) then
                    return {
                        x_mult = 2
                    }
                end
            else 
                return {
                    x_chips = card.ability.x_chips_return
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = "monster",
    atlas = "kino_enhancements",
    pos = { x = 2, y = 1},
    config = {
        chips = -25

    },
    hidden = true,
    replace_base_card = true,
    overrides_base_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.chips
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- When in hand, 1.5x chips, but 4/5 chance to turn into a monster card. 
        -- MONSTER Card: cannot be discarded. -50 chips 

        --G.FUNCS.can_discard = function(e)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.chips
            }
        end

        if context.after and context.cardarea == G.play then
            card:set_ability(G.P_CENTERS.m_kino_horror, nil, true)
        end
    end
}