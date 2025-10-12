---Apply value manipulation to target card
---@param card Card
---@param source string Source that will store value change
---@param num number Value that will be used to multiply values with
---@return boolean Returns true if successfully applied
function Card:bb_set_multiplication_bonus(card, source, num)
    if not card or not card.ability then
        return nil
    end

    -- Gather the right value manipulation method
    local _standard = Blockbuster.get_standard_from_card(card)
    
    if _standard and not Blockbuster.value_manipulation_compat(card, _standard) then
        return false
    end

    -- If No method was chosen, but a generic one exists, use generic one
    if _standard == nil and Cryptid then
        Blockbuster.Cryptid_bb_set_multiplication_bonus(card, source, num)
        return true
    end

    local _standardObj = Blockbuster.ValueManipulation.CompatStandards[_standard]

    if not card.ability.blockbuster_multipliers then
        card.ability.base = {}
        card.ability.blockbuster_multipliers = {}
        if type(card.ability.extra) ~= "table" then
            card.ability.base = card.ability.extra

        else
            for key, val in pairs(card.ability.extra) do
                if type(val) == 'number' then
                    card.ability.base[key] = val
                end
            end
        end
    end

    local _multipliers = card.ability.blockbuster_multipliers
    local _source = source
    local _num = num

    -- Add the source, or replace it if already existing
    if _source and _num then
        if card.ability.blockbuster_multipliers[_source] ~= nil and _num == 1 then
            card.ability.blockbuster_multipliers[source] = nil
        elseif card.ability.blockbuster_multipliers[_source] == _num then
            return false
        elseif _num ~= 1 then
            _multipliers[_source] = _num      
        end 
    end

    local _cardextra = card and card.ability.extra
    local _baseextra = card.ability.base

    -- Override is the personal standard that's on the joker object itself
    local _override = nil
    if card.config.center.bb_personal_standard then
        _override = card.config.center.bb_personal_standard
    end
    
    if type(_cardextra) ~= 'table' then
        if Blockbuster.check_variable_validity_for_mult("extra", _standard, _override) and type(_cardextra) == "number" then

            _cardextra = _baseextra

            for source, mult in pairs(_multipliers) do
                _cardextra = _cardextra * mult
                card.ability.extra = _cardextra
            end
        end
    else
        for name, value in pairs(_cardextra) do

            -- check the values

            if Blockbuster.check_variable_validity_for_mult(name, _standard, _override) and type(_cardextra[name]) == "number" then
                _cardextra[name] = _baseextra[name]
                for source, mult in pairs(_multipliers) do
                    _cardextra[name] = _cardextra[name] * mult
                end

                if Blockbuster.check_variable_validity_for_int_only(name, _standard, _override) then
                    _cardextra[name] = math.floor(_cardextra[name] + 0.5)
                end

                if (not _override and _standardObj and _standardObj.variable_caps and _standardObj.variable_caps[name]) or
                _override and _override.variable_caps and _override.variable_caps[name] then
                    local _usedStandard = _override or _standardObj
                    _cardextra[name] = math.min(_cardextra[name], _usedStandard.variable_caps[name])                    
                end

                if (not _override and _standardObj and _standardObj.min_max_values) or
                (_override and _override.min_max_values) then
                    local _usedStandard = _override or _standardObj 
                    local _min = _usedStandard.min_max_values.min
                    local _max = _usedStandard.min_max_values.max
                    _cardextra[name] = math.min(math.max(_cardextra[name], (_baseextra[name] * _min)), _baseextra[name] * _max)
                end
            end
        end
    end

    if Blockbuster.ValueManipulation.vanilla_exemption_joker_list[card.config.center.key] then
        Blockbuster.value_manipulation_vanilla_card(card, source, num)
    end

    return true
end

---Returns the current value of value manip from given source on target card
---@param card Card
---@param source string Source that will store value change 
---@return number
function Card:get_multiplier_by_source(card, source)
    if not card or not card.ability or 
    not card.ability.blockbuster_multipliers or 
    not card.ability.blockbuster_multipliers[source] then
        return false
    end

    return card.ability.blockbuster_multipliers[source]
end

---Returns total value of multipliers on target card
---@param card Card
---@return number
function Card:get_total_multiplier(card)
    if not card or not card.ability or 
    not card.ability.blockbuster_multipliers then
        return false
    end

    local _total = 0

    for _source, _mult in pairs(card.ability.blockbuster_multipliers) do
        if _mult > 1 then
            _total = _total + _mult
        end
    end
    return _total
end

---Manipulate values of target card
---@param card Card
---@param source string Key to store source under
---@param num number Value to turn multiplier into
---@param change? boolean If True will add num to existing value manip given by this source, rather than overwrite it
function Blockbuster.manipulate_value(card, source, num, change)
    if not card or not source or not num then
        return false
    end

    if not change then change = false end

    if change then
        local _curnum = card:get_multiplier_by_source(card, source) or 1
        num = _curnum + change
    end

    -- Temporary gate all use of blockbuster to jokers only
    if card.ability.set ~= "Joker" and Cryptid then
        Blockbuster.Cryptid_bb_set_multiplication_bonus(card, source, num)
        return true
    elseif card.ability.set ~= "Joker" then
        return false
    end

    -- quantum remove from deck to allow for specific effects
    if not card.added_to_deck then
        card:bb_set_multiplication_bonus(card, source, num)
        return true
    else
        card.from_quantum = true
        card:remove_from_deck(true)
        card:bb_set_multiplication_bonus(card, source, num)
        card:add_to_deck(true)
        card.from_quantum = true

        return true
    end
end

---Resets target sources of value manipulation on target
---@param card Card Target
---@param sources string|table Key or table of keys, will only reset matching keys
function Blockbuster.reset_value_multiplication(card, sources)
    if not card or not sources then
        return false
    end

    if type(sources) == 'string' then
        local _value = sources
        sources = {_value}
    end

    for _index, _source in ipairs(sources) do
        card.bb_set_multiplication_bonus(card, _source, 1)
    end

end

---Resets all values manipulation on target
---@param card Card
function Blockbuster.remove_all_value_multiplication(card)
    if card and card.ability and card.ability.multiplier then
        for _key, _mult in pairs(card.ability.multiplier) do
            card.bb_set_multiplication_bonus(card, _key, 1)
        end
    end
end

---Resets target sources of value manipulation on target if keys are full or partial match
---@param card Card Target
---@param sources string
function Blockbuster.remove_value_multiplication_if_partial_key_match(card, partial_key_match)
    if card and card.ability and card.ability.multiplier then
        for _key, _mult in pairs(card.ability.multiplier) do
            if string.find(_key, partial_key_match) then
                card.bb_set_multiplication_bonus(card, _key, 1)
            end
        end
    end
end
