---Returns Mod ID of target card's source mod
---@param card Card
---@return string? 
function Blockbuster.get_mod_id_from_card(card)
    if card then
        -- convert card to just the center
        local _center = nil

        if type(card) == "string" then
            _center = G.P_CENTERS[card]
        else 
            _center = card.config and card.config.center
        end

        if _center and _center.original_mod then
            return _center.original_mod.id
        end

        if _center and not _center.original_mod then
            return "Vanilla"
        end
    else
        return nil
    end
    
end

---Returns CompatStandard key of target card
---@param card Card
---@return string?
function Blockbuster.get_standard_from_card(card)
    if not card then
        return nil
    end

    local _center = nil
    if type(card) == "string" then
        _center = G.P_CENTERS[card]
    else 
        _center = card.config and card.config.center
    end

    if _center == nil then
        return nil
    end

    if _center.bb_alternate_standard then
        return _center.bb_alternate_standard
    end

    local _mod_id = Blockbuster.get_mod_id_from_card(card)

    local _standard_key = nil
    if _mod_id then
        _standard_key = Blockbuster.ValueManipulation.ModToCompatStandard[_mod_id]
    else
        return nil
    end

    if Blockbuster.ValueManipulation.CompatStandards[_standard_key] and Blockbuster.ValueManipulation.CompatStandards[_standard_key].redirect_objects then
        for _key, _dict in pairs(Blockbuster.ValueManipulation.CompatStandards[_standard_key].redirect_objects) do
            if _dict[card.config.center.key] then
                return _key
            end
        end
    end

    return _standard_key

end

---Return whether card is compatible with value manipulation based on its standard
---@param card Card
---@param string Standard
---@return boolean
function Blockbuster.value_manipulation_compat(card, standard)
    if not standard then 
        return nil
    end

    if type(standard) == "string" then
        standard = Blockbuster.ValueManipulation.CompatStandards[standard]
    end

    if standard.exempt_jokers and standard.exempt_jokers[card.config.center.key] then
        return false
    else
        return true
    end
end

---Returns keys of all value manipulation sources currently affecting target
---@param card Card
---@param partial_key_match string Set up to only include keys that contain string
---@return table
function Blockbuster.get_keys_of_value_manip_sources(card, partial_key_match)
    local _table = {}

    if card and card.ability and card.ability.multiplier then
        for _key, _garb in pairs(card.ability.multiplier) do
            if partial_key_match then
                if string.find(_key, partial_key_match) then
                    _table[#_table + 1] = _key
                end
            else
                _table[#_table + 1] = _key
            end
        end
    end

    return _table
end

---Returns whether card is value manip compatible generally
---@param card Card
---@return boolean
function Blockbuster.is_value_manip_compatible(card)
    if not card or not card.config or not card.config.center then
        return false
    end

    if Cryptid then
        return true
    end

    local _standard = card.config.center.bb_personal_standard or Blockbuster.get_standard_from_card(card)
    if _standard  then
        if Blockbuster.value_manipulation_compat(card, _standard) then
            return true
        end
    end

    return false
end