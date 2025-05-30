-- Containing functins and hooks that relate to Cryptid crossmod mechanics

if Cryptid then
    
local o_misprinterize = Cryptid.misprintize
function Cryptid.misprintize(card, override, force_reset, stack)
    if card and card.config and card.config.center and card.config.center.kino_joker then
        if card:can_calculate() then
            local _multiplier = card:get_multiplier_by_source(card, "cryptid_kino") or 1

            local _pickednum = pseudorandom("cryptid_misprint_kino", override and override.min or 1, override and override.max or 1)
            
            if stack then
                _multiplier = _multiplier * _pickednum
            else
                _multiplier = _pickednum
            end
            
            if force_reset then
                _multiplier = 1
            end

            Card:set_multiplication_bonus(card, "cryptid_kino", _multiplier)
        end
    else
        o_misprinterize(card, override, force_reset, stack)
    end
end

local o_csa = Card.set_ability
function Card:set_ability(center, y, z)
    if type(center) == 'string' then
        assert(G.P_CENTERS[center], ("Could not find center \"%s\""):format(center))
        center = G.P_CENTERS[center]
    end

    o_csa(self, center, y, z)
end


end