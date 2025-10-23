SMODS.Enhancement {
    key = "romance",
    atlas = "kino_enhancements",
    pos = { x = 3, y = 0},
    config = {
        extra = {
            chips_mult = 2,
            mult_mult = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.extra.chips_mult and self.config.chips_mult,
                card and card.ability.extra.mult_mult and self.config.mult_mult,
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- If a hand contains 2 scoring romance cards, 2x chips, 2x mult.
        if (context.main_scoring and context.cardarea == G.play) and not context.repetition then
            local _romance_count = 0
            local _is_left = false
            card.ability.extra.current_match = nil
            for i = 1, #context.scoring_hand do 
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_romance') then
                    if _romance_count == 0 and context.scoring_hand[i] == card then
                        _is_left = true
                    end
                    _romance_count = _romance_count + 1
                end
            end
            if _romance_count == 2 then
                update_matches(1)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_romance_match_ex'), colour = HEX("df92ea") })

                -- for jokers that give a bonus
                local _bonus = 0

                -- Add Twilight bonuses
                for i = 1, #G.jokers.cards do
                    if type(G.jokers.cards[i].ability.extra) == 'table' and G.jokers.cards[i].ability.extra.romance_bonus then
                        _bonus = _bonus + G.jokers.cards[i].ability.extra.romance_bonus
                    end
                end

                if _is_left then
                    SMODS.calculate_context({match_made = true})
                    return {
                        x_chips = card.ability.extra.chips_mult + _bonus
                    }
                else
                    return {
                        x_mult = card.ability.extra.mult_mult + _bonus
                    }
                end
            end
        end
    end
}