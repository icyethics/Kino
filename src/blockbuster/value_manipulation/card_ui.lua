---Returns localization key for the used standard
---@param card Card
---@return string
Blockbuster.get_localization_key_for_valmanip_standard = function(card)
    local _key = Blockbuster.get_standard_from_card(card)
    if _key == nil then
        _key = "none"
    else
        if Blockbuster.ValueManipulation.CompatStandards[_key].alt_loc_key then
            _key = Blockbuster.ValueManipulation.CompatStandards[_key].alt_loc_key
        end

        if not Blockbuster.value_manipulation_compat(card, _key) then
            _key = "none"
        end
    end

    return _key
end

local generate_UIBox_ability_tableref = Card.generate_UIBox_ability_table
function Card.generate_UIBox_ability_table(self, ...)
    local full_UI_table = generate_UIBox_ability_tableref(self, ...)

    if Blockbuster.ValueManipulation_config.compat_box then

        local _key = Blockbuster.get_localization_key_for_valmanip_standard(self)
        generate_card_ui({set = 'Other', key = "compat_standard_" .. _key}, full_UI_table)
    end

    if Blockbuster.ValueManipulation_config.display_current_boost then
        if self.get_total_multiplier then
            local _value = self:get_total_multiplier(self)
            if _value and _value > 1 then
                generate_card_ui({set = 'Other', key = "blockbuster_valmanip_boost", vars = {_value}}, full_UI_table)
            end
        end
    end


    return full_UI_table
end