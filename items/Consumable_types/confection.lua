if kino_config.confection_mechanic then
SMODS.ConsumableType {
    key = "confection",
    primary_colour = HEX("4F6367"),
    secondary_colour = HEX("4ABA8D"),
    loc_text = {
        name = "Confection",
        collection = "Confection Cards"
    },
    collection_row = {6, 6},
    shop_rate = 2,
    default = "c_kino_popcorn"
}

SMODS.UndiscoveredSprite {
    key = "confection",
    atlas = "kino_confections",
    pos = {x = 0, y = 3} 
}
end


Kino.confection_trigger = function(card)

    local _sound_key = card.config.center.sound_effect or "kino_bite"

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = localize('k_eaten'), colour = G.C.MULT})
        print(_sound_key)
        play_sound(_sound_key)
    return true end }))

    if card.ability.kino_goldleaf then
        ease_dollars(G.GAME.confections_goldleaf_bonus)
        G.GAME.confections_goldleaf_bonus = G.GAME.confections_goldleaf_bonus + 1
    end

    card.ability.extra.times_used = card.ability.extra.times_used + 1
    SMODS.calculate_context({confection_used = true, other_confection = card, times_used = card.ability.extra.times_used})
    inc_career_stat('kino_confections_consumed', 1)

    if card.ability.kino_goldleaf or card.ability.kino_extra_large or card.ability.kino_chocolate then
        inc_career_stat('kino_confections_with_treats_consumed', 1)
    end

    if card.ability.kino_chocolate then
        check_for_unlock({type="chocolate_confection_eaten"})
    end

    if card.ability.kino_extra_large and
    card.ability.extra.times_used < 2 then
        card:juice_up(0.8, 0.5)
        card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = localize('k_extra_large'), colour = G.C.MULT})
        card.active = false
    else
        card.active = false
        G.E_MANAGER:add_event(Event({
            func = (function()
                card.getting_sliced = true
                card:start_dissolve()
                return true
            end)
        }))
    end

    SMODS.calculate_context({post_confection_used = true, other_confection = card, times_used = card.ability.extra.times_used})
end

Kino.powerboost_confection = function(card, forced)
    if G.GAME.used_vouchers.v_kino_heavenly_treats or forced then

        if card == G.P_CENTERS.c_snackbag then return true end
        if card.ability.immutable then return true end

        for _key, _value in pairs(card.ability.extra) do
            if type(_value) == "number" and _key ~= 'times_used' then
                card.ability.extra[_key] = card.ability.extra[_key] * 2
            end
        end

        card.ability.choco_bonus = card.ability.choco_bonus * 2

        card:juice_up()
        card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = localize('k_kino_blessedconf'), colour = G.C.MONEY})
    end
end