-- BASE CODE WRITTEN AND PROVIDED BY ARSON

--Function to alter Scoring Joker effects
local base_calculate_joker = Card.calculate_joker
function Card.calculate_joker(self,context)
    local ret = base_calculate_joker(self, context)

    if self.ability.output_powerchange then
        -- calculate the multiplier. Numbers are always percentages
        local multiplier = 1
        for _source, _num in pairs(self.ability.output_powerchange) do
            multiplier = multiplier * _num
        end
        
        if self.ability.name == 'Blueprint' or self.ability.name == 'Brainstorm' and not context.end_of_round then
                return ret
        end

        if not ret then return ret end

        -- Mult
        if ret.x_mult then ret.x_mult = ret.x_mult * multiplier end
        if ret.h_mult then ret.h_mult = ret.h_mult * multiplier end
        if ret.mult then ret.mult = ret.mult * multiplier end

        -- Message overrides
        if ret.Xmult_mod then 
            ret.x_mult = ret.Xmult_mod * multiplier
            ret.message = nil 
        end
        if ret.mult_mod then 
            ret.mult = ret.mult_mod * multiplier 
            ret.message = nil
        end


        -- Chips
        if ret.chip_mod then 
            ret.chips = ret.chip_mod * multiplier 
            ret.message = nil
        end

        if ret.chips then ret.chips = ret.chips * multiplier end
    end

    if Cryptid and Talisman then
        if next(find_joker('j_kino_shrek_1')) then
            if not ret then return ret end
            local _shrek = find_joker('j_kino_shrek_1')
            if not _shrek[1] then 
                return ret
            else
                _shrek = _shrek[1]
            end

            if ret.mult or ret.mult_mod or ret.x_mult or ret.Xmult_mod then
                _shrek.ability.extra.triggers_non = _shrek.ability.extra.triggers_non + 1
            end
            
            if _shrek.ability.extra.triggers_non >= _shrek.ability.extra.threshold_non then
                _shrek.ability.extra.triggers_non = 0

                -- Set checks
                local _multchanged = false
                local _xmultchanged = false
                -- Message overrides
                if ret.Xmult_mod then 
                    ret.x_mult = ret.Xmult_mod
                    ret.message = nil 
                end
                if ret.mult_mod then 
                    ret.mult = ret.mult_mod
                    ret.message = nil
                end

                -- Upgrade
                if ret.mult then
                    ret.x_mult = ret.mult
                    _multchanged = true
                    ret.mult = nil
                end
                if ret.x_mult and not _multchanged then
                    ret.e_mult = ret.x_mult
                    ret.x_mult = nil
                    _xmultchanged = true
                end
            end
        end
    end
    return ret
end

local base_gcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    
    local ret = base_gcb(self)

    local _factor = 1
    if self.ability.output_powerchange then
        
        for _source, _num in pairs(self.ability.output_powerchange) do
            _factor = _factor * _num
        end
    end

    return ret * _factor
end

function Kino.setpowerchange(card, source, powerchange)
    if not card.ability.output_powerchange then
        card.ability.output_powerchange = {}
    end

    local _source = source
    local _num = powerchange

    -- Add the source, or replace it if already existing
    if _source and _num then
        if card.ability.output_powerchange[_source] == _num then
            return false
        elseif card.ability.output_powerchange[_source] ~= nil and _num == 1 then
            for index, item in ipairs(card.ability.output_powerchange) do
                if card.ability.output_powerchange[_source] == item then
                    table.remove(card.ability.output_powerchange, index)
                end    
            end
        end 

        card.ability.output_powerchange[_source] = _num        
    end

    return true
end