function Kino.get_blind(blind_type)
    local _return = 'bl_small'

    if blind_type == "Small" then
        _return = Kino.get_small_blind()
    elseif blind_type == "Big" then
        _return = Kino.get_big_blind()
    elseif blind_type == "Boss" then
        _return = get_new_boss()
    end

    return _return
end

function Kino.get_small_blind()
    local _blind = "bl_small"
    G.GAME.kino_boss_mode_small_is_boss = nil

    if G.GAME.kino_boss_mode and G.GAME.kino_boss_mode.Small then
        if SMODS.pseudorandom_probability(nil, 'kino_blind_roll', G.GAME.kino_boss_mode_odds.Small or 0, 1, "boss_reroll") then
            _blind = get_new_boss()
            G.GAME.kino_boss_mode_small_is_boss = true
        end
    end

    if G.GAME.modifiers.kino_boss_rush and G.GAME.round_resets.ante == G.GAME.win_ante then
        _blind = get_new_boss()
        G.GAME.kino_boss_mode_small_is_boss = true
    end

    return _blind
end

function Kino.get_big_blind()
    local _blind = "bl_big"
    G.GAME.kino_boss_mode_big_is_boss = nil

    if G.GAME.kino_boss_mode and G.GAME.kino_boss_mode.Big then
        if SMODS.pseudorandom_probability(nil, 'kino_blind_roll', G.GAME.kino_boss_mode_odds.Big or 0, 1, "boss_reroll") then
            _blind = get_new_boss()
            G.GAME.kino_boss_mode_big_is_boss = true
        end
    end

    if G.GAME.modifiers.kino_boss_rush and G.GAME.round_resets.ante == G.GAME.win_ante then
        _blind = get_new_boss()
        G.GAME.kino_boss_mode_big_is_boss = true
    end

    return _blind
end

-- Code provided by Bepis
local o_blind_get_type = Blind.get_type
function Blind.get_type(self)
    local _ret = o_blind_get_type(self)

    if G.GAME.blind.boss then
        if (G.GAME.round_resets.blind_states.Small == "Defeated" or G.GAME.round_resets.blind_states.Small == "Skipped") and (G.GAME.round_resets.blind_states.Big == "Current" or G.GAME.round_resets.blind_states.Big == "Select") then
            return "Big"
        elseif (G.GAME.round_resets.blind_states.Small == "Current" or G.GAME.round_resets.blind_states.Small == "Select") then
            return "Small"
        end
    else
    end

    return _ret
end

local o_end_round = end_round
end_round = function() --Same effect.
    if G.GAME.blind:get_type() == "Big" and G.GAME.kino_boss_mode_big_is_boss then
        G.GAME.round_resets.blind = G.P_BLINDS.bl_big
    end
    if G.GAME.blind:get_type() == "Small" and G.GAME.kino_boss_mode_small_is_boss then
        G.GAME.round_resets.blind = G.P_BLINDS.bl_small
    end

    local ret = o_end_round()
    return ret
end

function Kino.lower_blind(number, is_absolute)

    local _lower_by
    if is_absolute then
        _lower_by = number
    else
        _lower_by = G.GAME.blind.chips * (number / 100)
    end

    G.GAME.blind.chips = math.ceil(math.max(G.GAME.blind.chips - _lower_by, 1))
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end

local o_create_uibox_blind_tag = create_UIBox_blind_tag
function create_UIBox_blind_tag(blind_choice, run_info)
    if G.GAME.modifiers.kino_boss_rush and G.GAME.round_resets.ante == G.GAME.win_ante then

    else
        return o_create_uibox_blind_tag(blind_choice, run_info)
    end
end