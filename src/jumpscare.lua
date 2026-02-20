Kino.jumpscare_sounds = {
    "kino_boo_1",
    "kino_boo_2"
}

function Kino.jumpscare(card)
    inc_career_stat("kino_jumpscared_times", 1)
    check_for_unlock({type="kino_jumpscare"})
    -- local _sound_key = pseudorandom_element(Kino.jumpscare_sounds, pseudoseed("kino_jumpscare"))

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
        -- Kino.change_counters(card, "kino_stun", Kino.jumpscare_stunned_duration)
        play_sound("kino_boo_3", 1, 0.7)
        card:bb_counter_apply('counter_stun', 1)
        G.GAME.jumpscare_triggers = G.GAME.jumpscare_triggers + 1
        SMODS.calculate_context({kino_jumpscare = true, card = card})
    return true end }))
    
    return Kino.jump_scare_mult
end