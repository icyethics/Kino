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
        print("small blind might be Boss blind")
        if SMODS.pseudorandom_probability(nil, 'kino_blind_roll', G.GAME.kino_boss_mode_odds.Small or 0, 1, "boss_reroll") then
            print("Small blind WILL be a boss blind")
            _blind = get_new_boss()
            G.GAME.kino_boss_mode_small_is_boss = true
        end
    end

    return _blind
end

function Kino.get_big_blind()
    local _blind = "bl_big"
    G.GAME.kino_boss_mode_big_is_boss = nil

    print("entered")
    print(G.GAME.kino_boss_mode.Big)
    if G.GAME.kino_boss_mode and G.GAME.kino_boss_mode.Big then
        print("Big blind might be Boss blind")
        if SMODS.pseudorandom_probability(nil, 'kino_blind_roll', G.GAME.kino_boss_mode_odds.Big or 0, 1, "boss_reroll") then
            print("Big blind WILL be a boss blind")
            _blind = get_new_boss()
            G.GAME.kino_boss_mode_big_is_boss = true
        end
    end

    return _blind
end

-- Code provided by Bepis
local o_blind_get_type = Blind.get_type
function Blind.get_type(self)
    local _ret = o_blind_get_type(self)

    if G.GAME.blind.boss then
        if G.GAME.round_resets.blind_states.Small == "Current" then
            return "Small"
        elseif G.GAME.round_resets.blind_states.Big == "Current" then
            return "Big"
        end
    end

    return _ret
end