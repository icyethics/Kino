---Apply value manipulation to target card
---@param card Card
---@param source string Source that will store value change
---@param num number Value that will be used to multiply values with
---@param include_layers? table Dictionary marked with layers to include (All, Bonus, Base, Center (default), Edition)
---@return boolean Returns true if successfully applied
function Card:bb_set_multiplication_bonus(card, source, num, include_layers)
    if not card or not card.ability then
        return nil
    end

    if not include_layers then
        include_layers = {Center = true}
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
    card.ability.last_multiplication = card:get_total_multiplier(card) or 1

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
    
    local _tables_to_check = {}
    local _cardextra = card and card.ability.extra
    local _baseextra = card.ability.base

    -- The extra table is assumed to be generic and exist on every object
    if not include_layers or include_layers.All or include_layers.Center then
        _tables_to_check[#_tables_to_check + 1] = {target = (card and card.ability) and card.ability.extra, base = card.ability.base}

        -- These tables are only checked if the object is a consumeable
        if card and card.ability and card.ability.consumeable then
            local _reference_config = G.P_CENTERS[card.config.center.key].config

            if not card.ability.base_consumeable then card.ability.base_consumeable = copy_table(_reference_config) end
            _tables_to_check[#_tables_to_check + 1] = {target = card.ability.consumeable, base = card.ability.base_consumeable}
            _tables_to_check[#_tables_to_check + 1] = {target = card.ability, base = card.ability.base_consumeable}
        end
    end

    -- Logic to handle editons
    if card and card.ability and card.edition ~= nil and (include_layers.All or include_layers.Edition) then
        
        local _reference_config = G.P_CENTERS[card.edition.key].config
        _tables_to_check[#_tables_to_check + 1] = {target = card.edition, base = _reference_config}
    end

    -- Logic to handle base card bonuses
    if card and card.ability and (include_layers.All or include_layers.Base or include_layers.Bonus) then
        local _reference_config = card.ability.base_bonus_table or Blockbuster.construct_perma_bonus_table(card)
        _tables_to_check[#_tables_to_check + 1] = {target = card.ability, base = _reference_config}
    end

    -- Logic to handle seals (Unfinished)
    -- if card and card.ability and card.ability.seal ~= nil then
    --     local _reference_config = G.P_CENTERS[card.seal].config
    --     _tables_to_check[#_tables_to_check + 1] = {target = card.ability.seal, base = _reference_config}
    --     _tables_to_check[#_tables_to_check + 1] = {target = card.seal.config, base = _reference_config}
    -- end

    _tables_to_check = Blockbuster.add_table_to_value_manipulation(_tables_to_check, card, source, num, include_layers)

    -- Override is the personal standard that's on the joker object itself
    local _override = nil
    if card.config.center.bb_personal_standard then
        _override = card.config.center.bb_personal_standard
    end
    
    for _index, _table_set in ipairs(_tables_to_check) do
        Blockbuster.change_values_in_table(card, _table_set.target, _table_set.base, _standard, _multipliers, _override)
    end

    if Blockbuster.ValueManipulation.vanilla_exemption_joker_list[card.config.center.key] then
        Blockbuster.value_manipulation_vanilla_card(card, source, num)
    end

    return true
end

function Blockbuster.add_table_to_value_manipulation(tables_to_check, card, source, num, include_layers)
    -- To add specific tables and make them compatible with value manipulation, hook this function
    
    return tables_to_check
end

---Changes the specific value passed through, if it is compatible
function Blockbuster.change_values_in_table(card, value_table, reference_table, standard, multiplier_table, override)
    local _standardObj = Blockbuster.ValueManipulation.CompatStandards[standard]

    if type(value_table) ~= 'table' then
        if Blockbuster.check_variable_validity_for_mult("extra", standard, override) and type(value_table) == "number" then

            if type(reference_table) == 'table' then print("emergency, something is going wrong here!") end
            value_table = reference_table

            for source, mult in pairs(multiplier_table) do
                value_table = value_table * mult
                card.ability.extra = value_table
            end
        end
    else
        
        for name, value in pairs(value_table) do

            -- check the values
            if Blockbuster.check_variable_validity_for_mult(name, standard, override) and type(value_table[name]) == "number" and
            reference_table[name] then
                
                -- Keeps into account any changes that originated from other systems than this one
                local _current_value = value_table[name]
                local _no_changes_result = reference_table[name] * (card.ability.last_multiplication ~= 0 and card.ability.last_multiplication or 1)
                local _calculate_from = reference_table[name] + (_current_value - _no_changes_result) 

                value_table[name] = _calculate_from
                for source, mult in pairs(multiplier_table) do
                    value_table[name] = value_table[name] * mult
                end

                if Blockbuster.check_variable_validity_for_int_only(name, standard, override) then
                    value_table[name] = math.floor(value_table[name] + 0.5)
                end

                if (not override and _standardObj and _standardObj.variable_caps and _standardObj.variable_caps[name]) or
                override and override.variable_caps and override.variable_caps[name] then
                    local _usedStandard = override or _standardObj
                    value_table[name] = math.min(value_table[name], _usedStandard.variable_caps[name])                    
                end

                if (not override and _standardObj and _standardObj.min_max_values) or
                (override and override.min_max_vralues) then
                    local _usedStandard = override or _standardObj 
                    local _min = _usedStandard.min_max_values.min
                    local _max = _usedStandard.min_max_values.max
                    value_table[name] = math.min(math.max(value_table[name], (_calculate_from * _min)), _calculate_from * _max)
                end
            end
        end
    end
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
---@param include_layer? table Dictionary indicating targeted layers. Defaults to Center if absent
---@param change? boolean If True will add num to existing value manip given by this source, rather than overwrite it
function Blockbuster.manipulate_value(card, source, num, include_layers, change)
    if not card or not source or not num then
        return false
    end

    if not change then change = false end

    if change then
        local _curnum = card:get_multiplier_by_source(card, source) or 1
        num = _curnum + num
    end

    -- Temporary gate all use of blockbuster to jokers only
    if card.ability.set ~= "Joker" and Cryptid then
        Blockbuster.Cryptid_bb_set_multiplication_bonus(card, source, num)
        return true
    elseif card.ability.set ~= "Joker" then
        -- return false
    end

    -- quantum remove from deck to allow for specific effects
    if not card.added_to_deck then
        card:bb_set_multiplication_bonus(card, source, num, include_layers)
        return true
    else
        card.from_quantum = true
        card:remove_from_deck(true)
        card:bb_set_multiplication_bonus(card, source, num, include_layers)
        card:add_to_deck(true)
        card.from_quantum = true

        return true
    end
end

---Resets target sources of value manipulation on target
---@param card Card Target
---@param sources string|table Key or table of keys, will only reset matching keys
---@param include_layer table Dictionary indicating targeted layers. Defaults to Center if absent
function Blockbuster.reset_value_multiplication(card, sources, include_layer)
    if not card or not sources then
        return false
    end

    if type(sources) == 'string' then
        local _value = sources
        sources = {_value}
    end

    for _index, _source in ipairs(sources) do
        card:bb_set_multiplication_bonus(card, _source, 1, include_layer)
    end

end

---Resets all values manipulation on target
---@param card Card
function Blockbuster.remove_all_value_multiplication(card)
    if card and card.ability and card.ability.multiplier then
        for _key, _mult in pairs(card.ability.multiplier) do
            card:bb_set_multiplication_bonus(card, _key, 1, {All = true})
        end
    end
end

---Resets target sources of value manipulation on target if keys are full or partial match
---@param card Card Target
---@param partial_key_match string
---@param include_layer table Dictionary indicating targeted layers. Defaults to Center if absent
function Blockbuster.remove_value_multiplication_if_partial_key_match(card, partial_key_match, include_layer)
    if card and card.ability and card.ability.multiplier then
        for _key, _mult in pairs(card.ability.multiplier) do
            if string.find(_key, partial_key_match) then
                card:bb_set_multiplication_bonus(card, _key, 1, include_layer)
            end
        end
    end
end

---Constructs the table of relevant values for bonus manipulation
---@param card Card target card
---@return table
function Blockbuster.construct_perma_bonus_table(card)

    local _perma_table = {
        perma_x_chips = card.ability.perma_x_chips ~= 0 and (card.ability.perma_x_chips + 1) or 0,
        perma_mult = card.ability.perma_mult ~= 0 and card.ability.perma_mult or 0,
        perma_x_mult = card.ability.perma_x_mult ~= 0 and (card.ability.perma_x_mult + 1) or 0,
        perma_h_chips = card.ability.perma_h_chips ~= 0 and card.ability.perma_h_chips or 0,
        perma_h_x_chips = card.ability.perma_h_x_chips ~= 0 and (card.ability.perma_h_x_chips + 1) or 0,
        perma_h_mult = card.ability.perma_h_mult ~= 0 and card.ability.perma_h_mult or 0,
        perma_h_x_mult = card.ability.perma_h_x_mult ~= 0 and (card.ability.perma_h_x_mult + 1) or 0,
        perma_p_dollars = card.ability.perma_p_dollars ~= 0 and card.ability.perma_p_dollars or 0,
        perma_h_dollars = card.ability.perma_h_dollars ~= 0 and card.ability.perma_h_dollars or 0,
        bonus = card.ability.bonus ~= 0 and card.ability.bonus or 0,
        perma_bonus = card.ability.perma_bonus ~= 0 and card.ability.perma_bonus or 0,
        bonus_repetitions = card.ability.perma_repetitions ~= 0 and card.ability.perma_repetitions or 0,
    }

    card.ability.base_bonus_table = _perma_table   

    return _perma_table
end
