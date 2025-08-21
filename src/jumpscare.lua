function Kino.jumpscare(card)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
        -- Kino.change_counters(card, "kino_stun", Kino.jumpscare_stunned_duration)
        card:bb_counter_apply('counter_stun', 1)
        G.GAME.jumpscare_triggers = G.GAME.jumpscare_triggers + 1
        SMODS.calculate_context({kino_jumpscare = true, card = card})
    return true end }))
    
    return Kino.jump_scare_mult
end