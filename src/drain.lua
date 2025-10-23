-- Drain mechanic. Reduces or removes targetted quality (or debuffs)
-- Returns True if successful
function Kino.drain_property(target, source, property_table)
    local _result = false

    if Blockbuster.Counters.is_counter(target, "counter_kino_blood") then
        target:bb_increment_counter(-1)
        card_eval_status_text(target, 'extra', nil, nil, nil,
        { message = localize('k_kino_drained'), colour = G.C.KINO.DRAIN})
        return true
    end

    local _targeted_properties = {}
    if type(property_table) == 'string' then
        _targeted_properties[#_targeted_properties] = property_table
    elseif type(property_table) == 'table' then
        _targeted_properties = property_table
    end

    if property_table.Enhancement and not target.drained_enhancement and
    target.config.center ~= G.P_CENTERS.c_base and 
    not target.debuff and not target.vampired then
        target.drained_enhancement = true
        if not property_table.Enhancement.debuff then
            target:set_ability(G.P_CENTERS.c_base, nil, true)
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                target:flip()
                if property_table.Enhancement.debuff then
                    SMODS.debuff_card(target, true, type(property_table.Enhancement.debuff) == 'string' or nil)
                end
                target:juice_up()
                target.drained_enhancement = nil
                delay(0.2)

                target:flip()
                return true
            end
        }))
        _result = true
    end

    -- Rank (has intensity)
    if property_table.Rank and not target.drained_rank and
    not SMODS.has_no_rank(target) then
        target.drained_rank = true

        G.E_MANAGER:add_event(Event({
            func = function()
                target:flip()
                if property_table.Rank.Intensity then
                    assert(SMODS.modify_rank(target, -property_table.Rank.Intensity))
                else
                    assert(SMODS.modify_rank(target, -1))
                end

                target:juice_up()
                target.drained_rank = nil
                delay(0.2)
                
                target:flip()
                return true
            end
        }))
        _result = true
    end

    -- Suit
    if property_table.Suit and not target.drained_suit and
    target:is_suit(property_table.Suit.target_suit) and
    not SMODS.has_no_suit(target) then
        target.drained_suit = true



        G.E_MANAGER:add_event(Event({
            func = function()
                target:flip()

                if property_table.Suit.debuff then
                    SMODS.debuff_card(target, true, type(property_table.Suit.debuff) == 'string' or nil)
                else

                end
                target:juice_up()
                target.drained_suit = nil
                delay(0.2)
                target:flip()
                return true
            end
        }))
        _result = true
    end

    
    -- Full debuff
    if property_table.Base and not target.drained_base then
        target.drained_base = true



        G.E_MANAGER:add_event(Event({
            func = function()
                target:flip()
                if property_table.Base.debuff then
                    SMODS.debuff_card(target, true, type(property_table.Base.debuff) == 'string' or "default")
                else

                end
                target:juice_up()
                target.drained_base = nil
                delay(0.2)
                target:flip()
                return true
            end
        }))
        _result = true
    end
    if _result == true then
        card_eval_status_text(target, 'extra', nil, nil, nil,
        { message = localize('k_kino_drained'), colour = G.C.KINO.DRAIN})
    end
    return _result
end