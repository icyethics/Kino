local hookTo = end_round
end_round = function() --Same effect.
    if G.GAME.blind:get_type() == "Big" and G.GAME.kino_boss_mode == true then

        G.GAME.round_resets.blind = G.P_BLINDS.bl_big
    end
    if G.GAME.blind:get_type() == "Small" and G.GAME.kino_boss_mode == true then

        G.GAME.round_resets.blind = G.P_BLINDS.bl_small
    end

    local ret = hookTo()

    if G.GAME.blind:get_type() == "Boss" and G.GAME.kino_boss_mode == true then

        G.GAME.RESET_BIG_BLIND = true
    end
    if G.GAME.blind:get_type() == "Boss" and G.GAME.kino_boss_mode == true then

        G.GAME.RESET_SMALL_BLIND = true
    end

    if G.GAME.blind:get_type() == "Boss" and G.GAME.kino_boss_mode == true then
        G.GAME.current_round.reroll_cost_increase = 0
        calculate_reroll_cost(true)
    end

    return ret
end

local get_typeref = Blind.get_type
function Blind.get_type(self) --Ensuring that defeating a Boss Blind (replacing Big Blinds) won't reset to Small Blind.
    if (G.GAME.round_resets.blind_states.Small == "Defeated" or G.GAME.round_resets.blind_states.Small == "Skipped") and (G.GAME.round_resets.blind_states.Big == "Current" or G.GAME.round_resets.blind_states.Big == "Select") and G.GAME.kino_boss_mode == true then
        return "Big"
    end
    if (G.GAME.round_resets.blind_states.Small == "Current" or G.GAME.round_resets.blind_states.Small == "Select") and G.GAME.kino_boss_mode == true then

        return "Small"
    end
    return get_typeref(self)
end

local hookTo = create_UIBox_blind_select
function create_UIBox_blind_select() --Randomizing Big and Small blinds to Boss.
    if G.GAME.RESET_BIG_BLIND and G.GAME.kino_boss_mode == true and
    pseudorandom("kino_bossmode") < G.GAME.kino_boss_mode_odds then

        G.GAME.RESET_BIG_BLIND = false
        G.GAME.round_resets.blind_choices.Big = get_new_boss() 
    end
    if G.GAME.RESET_SMALL_BLIND and G.GAME.kino_boss_mode == true and
    pseudorandom("kino_bossmode") < G.GAME.kino_boss_mode_odds then

        G.GAME.RESET_SMALL_BLIND = false
        G.GAME.round_resets.blind_choices.Small = get_new_boss() 
    end

    local ret = hookTo()
 
    return ret
end