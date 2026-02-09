if next(SMODS.find_mod("MoreFluff")) then


SMODS.Enhancement {
    key = "rotisserie",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 4, y = 0},
    config = {
        extra = {
            segment_heat = {
                3, 3, 3, 3, 
                3, 3, 3, 3
            },
            cur_rot = 1,
            heating_rate = 1,
            cooling_rate = 0.2,
            mult_table = {
                0, 4, 8, 12,
                30, 40, 8, 0
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                Kino.rotisserie_scoring(card)
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.before and context.cardarea == G.hand then
            -- Cook the right targets
            
            local _target_1 = math.ceil((card.ability.extra.cur_rot / 2))
            local _target_2 = _target_1 + 1

            if _target_2 > 8 then _target_2 = 1 end

            G.E_MANAGER:add_event(Event({
                func = function()
                    for _index, _value in ipairs(card.ability.extra.segment_heat) do
                        if _index == _target_1 or _index == _target_2 then
                            card.ability.extra.segment_heat[_index] = math.max(math.min(card.ability.extra.segment_heat[_index] + card.ability.extra.heating_rate, 8), 1)
                        else
                            card.ability.extra.segment_heat[_index] = math.max(math.min(card.ability.extra.segment_heat[_index] - card.ability.extra.cooling_rate, 8), 1)
                        end
                    end
                    return true
                end
            }))
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_cooked'), colour = G.C.BLACK})
            
            -- Turn the chicken
            for i = 1, #G.play.cards do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        card.ability.extra.cur_rot = card.ability.extra.cur_rot + 1
                        if card.ability.extra.cur_rot > 16 then
                            card.ability.extra.cur_rot = 1
                        end
                        return true
                    end
                }))
            end
        end

        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = Kino.rotisserie_scoring(card)
            }
        end
    end,
}

function Kino.rotisserie_scoring(card)
    local _average, _deviation = Kino.standard_deviation(card.ability.extra.segment_heat)
    -- min deviation = 0, max deviation = 3.5
    local _average_rounded = math.floor(_average + 0.5)
    
    -- penalties for burning or raw meat
    local _mult_penalties = 0

    for _index, _value in ipairs(card.ability.extra.segment_heat) do

        if _value == 1 or _value == 8 then
            _mult_penalties = _mult_penalties + 1
        end
    end


    local _mult_given_flat = math.max((card.ability.extra.mult_table[_average_rounded]) - _mult_penalties, 0)
    local _mult_modifier_percentage = _deviation <= 0 and 1 or _deviation / 3.5

    local _finalized_mult = math.max(_mult_given_flat * _mult_modifier_percentage, 0)
    return _finalized_mult
end

function Kino.standard_deviation(table)
    local _total = 0
    local _mean = 0
    local _standard_variance = 0
    local _standard_deviation = 0

    -- set mean
    for _index, _value in ipairs(table) do
        _total = _total + _value
    end
    _mean = _total / #table

    -- find deviations
    local _deviations_total = 0
    for _index, _value in ipairs(table) do
        local _deviation = (_mean - _value) ^ 2
        _deviations_total = _deviations_total + _deviation
    end
    _standard_variance = _standard_variance / #table
    _standard_deviation = math.sqrt(_standard_variance)

    return _mean, _standard_deviation
end


SMODS.DrawStep {
    key = "kino_morefluff_rotisserie",
    order = 2,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS.m_kino_rotisserie and G.rotisserie_sprites then

            for i = 1, 8 do
                local _heat = math.floor(card.ability.extra.segment_heat[i] + 0.5)
                local _current_sprite = G.rotisserie_sprites[i][_heat]

                local _rotate_mod = card.ability.extra.cur_rot * 22.5
                card.kino_rotisserie_card_rotation = card.kino_rotisserie_card_rotation or 0
                local _currentrotation_target = (_rotate_mod / 360) * 2*math.pi
                local _difference = _currentrotation_target - card.kino_rotisserie_card_rotation
                card.kino_rotisserie_card_rotation = card.kino_rotisserie_card_rotation + (_difference * 0.02*math.sin(0.1*G.TIMERS.REAL))

                _current_sprite.role.draw_major = card
                _current_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, _currentrotation_target, nil, nil, nil, 0.6)
            end

        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

end