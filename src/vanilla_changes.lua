-- For Vanilla objects which has its functionality changed by Kino content

-- Lucky Cards: Changed to allow the Prestige to upgrade them, and display those upgrades
SMODS.Enhancement:take_ownership('lucky', {
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        local numerator_mult, denominator_mult = SMODS.get_probability_vars(card, 1 * (cfg.lucky_bonus or 1), 5, 'lucky_mult')
        local numerator_dollars, denominator_dollars = SMODS.get_probability_vars(card, 1 * (cfg.lucky_bonus or 1), 15, 'lucky_money')
        return {vars = {numerator_mult, cfg.mult, denominator_mult, cfg.p_dollars, denominator_dollars, numerator_dollars}}
    end,
},
true)

-- Vampire: Changed to allow it to run as a Vampiric Joker
SMODS.Joker:take_ownership('vampire', {
    config = {
        is_vampire = true,
        extra = {
            a_xmult = 0.1,
            stacked_xmult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1]  = {set = 'Other', key = "keyword_drain"}    
        return {
            vars = {
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before and not context.blueprint then
                -- Add mult and drain
                local enhanced = {}
                for k, v in ipairs(context.scoring_hand) do
                    if Kino.drain_property(v, card, {Enhancement = {true}}) then
                        enhanced[#enhanced+1] = v
                    end
                end

                if #enhanced > 0 then
                    card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult * #enhanced
                    return {
                        extra = { focus = card,
                        message = localize({type='variable', key='a_mult', vars = {card.ability.extra.stacked_xmult}}),
                        colour = G.C.MULT,
                        card = card
                        }
                    }
                end
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end
    end
})