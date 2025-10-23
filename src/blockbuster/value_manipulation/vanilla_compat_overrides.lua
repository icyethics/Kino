---Table of vanilla joker keys that depend on hardcoded compatibility
---@class vanilla_exemption_joker_list
Blockbuster.ValueManipulation.vanilla_exemption_joker_list = {
    j_joker = true,

    j_jolly = true,
    j_zany = true,
    j_mad = true,
    j_crazy = true,
    j_droll = true,

    j_sly = true,
    j_wily = true,
    j_clever = true,
    j_devious = true,
    j_crafty = true,

    j_juggler = true,
    j_drunkard = true,

    j_popcorn = true,
    j_ramen = true,
    j_swashbuckler = true,
    j_duo = true,
    j_trio = true,
    j_family = true,
    j_order = true,
    j_tribe = true,
    j_yorick = true,

    -- With the system expanded to non-jokers, here's the enhancements:
    m_bonus = true,
    m_mult = true,
    m_glass = true,
    m_steel = true,
    m_stone = true,
    m_gold = true,
    m_lucky = true
}

---Hardcoded behaviour to deal with incompatible vanilla code
---@param card Card
---@param source string Key to store multiplier
---@param num number 
function Blockbuster.value_manipulation_vanilla_card(card, source, num)
    local _multipliers = card.ability.blockbuster_multipliers

    -- Joker
    if card.config.center.key == "j_joker" then
        card.ability.base = 4
        card.ability.mult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.mult = card.ability.mult * mult
        end
    end

    -- Hand type Mult
    if card.config.center.key == "j_jolly" or
    card.config.center.key == "j_zany" or
    card.config.center.key == "j_mad" or
    card.config.center.key == "j_crazy" or
    card.config.center.key == "j_droll" then
        
        if not card.ability.base then
            card.ability.base = card.ability.t_mult
        end
        
        card.ability.t_mult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.t_mult = card.ability.t_mult * mult
        end
    end

    -- Hand Type Chips
    if card.config.center.key == "j_sly" or
    card.config.center.key == "j_wily" or
    card.config.center.key == "j_clever" or
    card.config.center.key == "j_devious" or
    card.config.center.key == "j_crafty" then
        
        if not card.ability.base then
            card.ability.base = card.ability.t_chips
        end

        card.ability.t_chips = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.t_chips = card.ability.t_chips * mult
        end
    end

    -- Juggler
    if card.config.center.key == 'j_juggler' then
        if not card.ability.base then
            card.ability.base = card.ability.h_size
        end

        card.ability.h_size = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.h_size = card.ability.h_size * mult
        end
    end

    -- Drunkard
    if card.config.center.key == 'j_drunkard' then
        if not card.ability.base then
            card.ability.base = card.ability.d_size
        end

        card.ability.d_size = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.d_size = card.ability.d_size * mult
        end
    end


    -- Popcorn
    local _food_joker_table = {
        {key = "j_popcorn", value = "mult", base_value = 4},
        {key = "j_ramen", value = "x_mult", base_value = 0.01},
    }
 
    for _index, _dict in ipairs(_food_joker_table) do
        if card.config.center.key == _dict.key then
            if not card.ability.base_set then
                card.ability.base = card.ability[_dict.value]
                card.ability.base_set = true
            end

            local _current_value = card.ability[_dict.value]
            local _no_changes_result = card.ability.base * ((card.ability.last_multiplication and card.ability.last_multiplication ~= 0) and card.ability.last_multiplication or 1)
            local _calculate_from = card.ability.base + (_current_value - _no_changes_result)

            card.ability[_dict.value] = _calculate_from
            for source, mult in pairs(_multipliers) do
                card.ability[_dict.value] = card.ability[_dict.value] * mult
            end
            card.ability.extra = _dict.base_value
        end
    end

    -- Swashbuckler
    if card.config.center.key == "j_swashbuckler" then
        if not card.ability.base then
            card.ability.base = card.ability.mult
        end

        card.ability.mult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.mult = card.ability.mult * mult
        end
    end

    -- Hand Type Xmult
    if card.config.center.key == "j_duo" or
    card.config.center.key == "j_trio" or
    card.config.center.key == "j_family" or
    card.config.center.key == "j_order" or
    card.config.center.key == "j_tribe" then
        
        if not card.ability.base then
            card.ability.base = card.ability.Xmult
        end

        card.ability.Xmult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.Xmult = card.ability.Xmult * mult
        end
    end
    
    -- Yorick
    if card.config.center.key == "j_yorick" then
        if not card.ability.base then
            card.ability.base = card.ability.xmult
        end

        card.ability.xmult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.xmult = card.ability.xmult * mult
        end
    end

    -- === ENHANCEMENTS ===
    -- Bonus && Stone
    if card.config.center.key == "m_bonus" or 
    card.config.center.key == "m_stone" then
        if not card.ability.base then
            card.ability.base = card.ability.bonus
        end

        card.ability.bonus = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.bonus = card.ability.bonus * mult
        end
    end

    -- Mult
    if card.config.center.key == "m_mult" then
        if not card.ability.base then
            card.ability.base = card.ability.mult
        end

        card.ability.mult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.mult = card.ability.mult * mult
        end
    end
    
    -- Glass
    if card.config.center.key == "m_glass" then
        if not card.ability.base_xmult then
            card.ability.base_xmult = card.ability.Xmult
        end

        card.ability.Xmult = card.ability.base_xmult
        for source, mult in pairs(_multipliers) do
            card.ability.Xmult = card.ability.Xmult * mult
        end
    end

    -- Steel
    if card.config.center.key == "m_steel" then
        if not card.ability.base then
            card.ability.base = card.ability.h_x_mult
        end

        card.ability.Xmult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.h_x_mult = card.ability.h_x_mult * mult
        end
    end

    -- Gold
    if card.config.center.key == "m_gold" then
        if not card.ability.base then
            card.ability.base = {
                mult = card.ability.mult,
                p_dollars = card.ability.p_dollars
            }
        end

        card.ability.mult = card.ability.base.mult
        card.ability.p_dollars = card.ability.base.p_dollars
        for source, mult in pairs(_multipliers) do
            card.ability.mult = card.ability.mult * mult
            card.ability.p_dollars = card.ability.p_dollars * mult
        end
    end

    -- Lucky
    if card.config.center.key == "m_lucky" then
        if not card.ability.base then
            card.ability.base = card.ability.h_dollars
        end

        card.ability.Xmult = card.ability.base
        for source, mult in pairs(_multipliers) do
            card.ability.h_dollars = card.ability.h_dollars * mult
        end
    end
end

---Take Ownership functions to introduce joker specific standards to vanilla jokers
function Blockbuster.vanilla_joker_qualities()

    local _chips_jokers = {"runner", "square", "castle", "wee", "stuntman"}

    for _index, _key in ipairs(_chips_jokers) do
        SMODS.Joker:take_ownership(_key,
            { -- table of properties to change from the existing object
                bb_alternate_standard = "vanilla_chips"
            },
            true
        )
    end
    

    -- Individual vanilla joker overrides
    SMODS.Joker:take_ownership("j_ice_cream",
        { -- table of properties to change from the existing object
            bb_personal_standard = {
                variable_conventions = {
                    full_vars = {
                        "chip_mod",
                    },
                    ends_on = {
                    },
                    starts_with = {
                    }
                },
            }
        },
        true
    )

    SMODS.Joker:take_ownership("j_rocket",
        { -- table of properties to change from the existing object
            bb_personal_standard = {
                variable_conventions = {
                    full_vars = {
                        "dollars",
                    },
                    ends_on = {
                    },
                    starts_with = {
                    }
                },
            }
        },
        true
    )
    
    SMODS.Joker:take_ownership("j_popcorn",
        { -- table of properties to change from the existing object
            bb_personal_standard = {
                variable_conventions = {
                    full_vars = {
                        "extra",
                    },
                    ends_on = {
                    },
                    starts_with = {
                    }
                },
            }
        },
        true
    )    

    SMODS.Joker:take_ownership("j_ramen",
        { -- table of properties to change from the existing object
            bb_personal_standard = {
                variable_conventions = {
                    full_vars = {
                        "extra",
                    },
                    ends_on = {
                    },
                    starts_with = {
                    }
                },
            }
        },
        true
    )

    
    SMODS.Joker:take_ownership("j_bootstraps",
        { -- table of properties to change from the existing object
            bb_personal_standard = {
                variable_conventions = {
                    full_vars = {
                        "dollars",
                    },
                    ends_on = {
                    },
                    starts_with = {
                    }
                },
            }
        },
        true
    )
    
    
end