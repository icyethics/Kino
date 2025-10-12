---Checks variable name against standard conventions to judge value manip compatibility
---@param name string Key of target variable
---@param compat_standard_key string Key of CompatStandard used
---@param override CompatStandard CompatStandard or table with shared format to use instead of assumed standard
---@return boolean Returns True if compatible
function Blockbuster.check_variable_validity_for_mult(name, compat_standard_key, override)

    if not compat_standard_key and not override then return false end

    local compat_standard = Blockbuster.ValueManipulation.CompatStandards[compat_standard_key]
    if override then
        compat_standard = override
    end

    -- Return if it doesn't exist
    if not compat_standard.variable_conventions then
        return true
    end

    -- Check variable name
    for i = 1, #compat_standard.variable_conventions.full_vars do
        if name == compat_standard.variable_conventions.full_vars[i] then
            return false
        end
    end

    -- Check variable start
    for i = 1, #compat_standard.variable_conventions.ends_on do
        if string.sub(name, -#compat_standard.variable_conventions.ends_on[i]) == compat_standard.variable_conventions.ends_on[i] then
            return false
        end
    end

    -- Check variable ends
    for i = 1, #compat_standard.variable_conventions.starts_with do
        if string.sub(name, 1, #compat_standard.variable_conventions.starts_with[i]) == compat_standard.variable_conventions.starts_with[i] then
            return false
        end
    end

    return true
end

---Checks variable name against standard conventions to judge if value must be rounded to integer
---@param name string Key of target variable
---@param compat_standard_key string Key of CompatStandard used
---@param override CompatStandard CompatStandard or table with shared format to use instead of assumed standard
---@return boolean Returns True if value must be Integer
function Blockbuster.check_variable_validity_for_int_only(name, compat_standard_key, override)
    
    if not compat_standard_key and not override then return false end

    local compat_standard = Blockbuster.ValueManipulation.CompatStandards[compat_standard_key]
    if override then
        compat_standard = override
    end

    -- Return if it doesn't exist
    if not compat_standard.integer_only_variable_conventions then
        return false
    end

    -- Check variable name
    for i = 1, #compat_standard.integer_only_variable_conventions.full_vars do
        if name == compat_standard.integer_only_variable_conventions.full_vars[i] then
            return true
        end
    end

    -- Check variable start
    for i = 1, #compat_standard.integer_only_variable_conventions.starts_with do
        if string.sub(name, -#compat_standard.integer_only_variable_conventions.starts_with[i]) == compat_standard.integer_only_variable_conventions.starts_with[i] then
            return true
        end
    end

    -- Check variable ends
    for i = 1, #compat_standard.integer_only_variable_conventions.ends_on do
        if string.sub(name, 1, #compat_standard.integer_only_variable_conventions.ends_on[i]) == compat_standard.integer_only_variable_conventions.ends_on[i] then
            return true
        end
    end

    return false
end