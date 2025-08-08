SMODS.Enhancement {
    key = "demonic",
    atlas = "kino_enhancements",
    pos = { x = 1, y = 0},
    config = {
        a_xmult = 0.25
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.x_mult or self.config.x_mult,
                card and card.ability.base_xmult or self.config.base_xmult,
                card and card.ability.a_xmult or self.config.a_xmult
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- If hand contains a demonic card, destroy the lowest scoring non-demonic card
        
        if context.main_scoring and context.cardarea == G.play and
        not next(find_joker("j_kino_hellboy_1")) then
            local xmult = 0
            local _lowest_card = nil
            for i = 1, #context.scoring_hand do
                if not SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_demonic') then
                    if not _lowest_card or (_lowest_card:get_id() > context.scoring_hand[i]:get_id()) then
                        _lowest_card = context.scoring_hand[i]
                    end
                    
                    xmult = xmult + card.ability.a_xmult
                end
            end

            if _lowest_card then
                _lowest_card.marked_for_sacrifice = true

                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_sacrifice'), colour = G.C.BLACK })
                
                return {
                    x_mult = 1 + xmult
                }
            end
        end

        if context.destroy_card and context.destroy_card.marked_for_sacrifice and
        not next(find_joker("j_kino_hellboy_1")) then
            SMODS.calculate_context({kino_sacrifices = true, kino_sacrifice_num = 1, kino_sacrificed_cards = {context.destroy_card}})
            G.GAME.current_round.sacrifices_made = G.GAME.current_round.sacrifices_made + 1
            -- Challenge specific
            if G.GAME.modifiers.kino_bestsong then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = (function()     
                        ease_discard(1)
                    return true end)
                }))
            end
            
            return {
                remove = true
            } 
        end

        -- OLD CODE
        -- if (context.before and context.cardarea == G.play and not context.repetition) then
        --     local sacrifices = false
        --     local _total_gain = 0
        --     for i = 1, #context.scoring_hand do
        --         if not SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_demonic') then
        --             sacrifices = true
        --             _total_gain = _total_gain + card.ability.a_xmult
        --         end
        --     end

        --     if sacrifices then
        --         card.ability.x_mult = card.ability.base_xmult + _total_gain
        --         card_eval_status_text(card, 'extra', nil, nil, nil,
        --         { message = localize('k_sacrifice'), colour = G.C.BLACK })
        --     end
        -- end
    end
}