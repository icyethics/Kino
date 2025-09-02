-- Function that handles that general behaviour
function Blockbuster.Counters.setpowerchange(card, source, powerchange)
    Kino.setpowerchange(card, source, powerchange)

    return true
end

local o_cie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret = o_cie(effect, scored_card, key, amount, from_edition)

    if (key == 'bb_counter_number_change') then
        return {[key] = amount}
    end

    return ret
end