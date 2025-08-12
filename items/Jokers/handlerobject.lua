SMODS.Joker {
    key = "handlerobject",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 0},
    cost = 0,
    blueprint_compat = true,
    perishable_compat = true,
    no_collection = true,
    no_doe = true,
    in_pool = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)

        -- Retrigger Counters
        if context.retrigger_joker_check and context.other_card ~= self then
            if context.other_card and context.other_card.ability and 
            context.other_card.ability.kino_counter == "kino_retrigger" then
                local _retriggers = context.other_card.ability.kino_numcounters

                if G.STATE == G.STATES.HAND_PLAYED then
                    context.other_card.ability.kino_retrigger_counters_triggered = true
                else
                    context.other_card.ability.kino_numcounters = context.other_card.ability.kino_numcounters - 1
                end
                
                return {
					message = localize("k_again_ex"),
					repetitions = _retriggers
				}
            end
        end

        if context.after then
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker.ability.kino_retrigger_counters_triggered then
                    _joker.ability.kino_retrigger_counters_triggered = nil
                    _joker.ability.kino_numcounters = _joker.ability.kino_numcounters - 1
                end

                -- stun counters
                if _joker.ability.kino_counter == "kino_stun" then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                        Kino.stun_effect(_joker)
                    return true end }))
                end

                -- Debt counters
                if _joker.ability.kino_counter == "kino_debt" then
                    Kino.debt_counter_effect(_joker)
                end

                -- Finance counters
                if _joker.ability.kino_counter == "kino_investment" then
                    Kino.investment_counter_effect(_joker)
                end

                -- Power counters
                if _joker.ability.kino_counter == "kino_power" then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                        Kino.power_counter_effect(_joker)
                    return true end }))
                end

                -- Poison counter
                if _joker.ability.kino_counter == "kino_poison" then
                    return Kino.poison_effect(_joker)
                end
            end

            -- -- PLAYING CARD CHECKS
            -- In Hand 
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard.ability.kino_counter == "kino_stun" then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                        Kino.stun_effect(_pcard)
                    return true end }))
                end
            end

            -- In Play
            for _index, _pcard in ipairs(G.play.cards) do
                if _pcard.ability.kino_counter == "kino_stun" then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                        Kino.stun_effect(_pcard)
                    return true end }))
                end
            end
        end

        -- Finance/Debt counters
        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card.ability then
                if context.other_card.ability.kino_counter == "kino_investment" then
                    Kino.investment_counter_effect (context.other_card)
                end

                if context.other_card.ability.kino_counter == "kino_debt" then
                    Kino.debt_counter_effect(context.other_card)
                end

                -- Lower scored chips and mult by x%
                if context.other_card.ability.kino_counter == "kino_poison" then
                    return Kino.poison_effect(context.other_card)
                end
            end
        end



                

        -- Chain counters
        if context.pre_discard and context.full_hand then
            for _index, _pcard in ipairs(context.full_hand) do
                if _pcard.ability.kino_counter == "kino_chained" then
                    Kino.chain_effect(_pcard)
                end
            end
        end

        

    end,
    add_to_deck = function(self, card, from_debuff)
    end
}