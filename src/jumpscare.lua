function Kino.jumpscare(card)
    Kino.change_counters(card, "kino_stun", Kino.jumpscare_stunned_duration)
    G.GAME.jumpscare_triggers = G.GAME.jumpscare_triggers + 1
    SMODS.calculate_context({kino_jumpscare = true, card = card})
    return Kino.jump_scare_mult
end