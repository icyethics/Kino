-- Draws counters
SMODS.DrawStep {
    key = "kino_counter_draw",
    order = 71,
    func = function(card, layer)
        if card and card.ability.kino_counter and 
        card.ability.kino_numcounters > 0 then
            local card_type = card.ability.set
            local _suffix = "jokers"
            if card_type == 'Default' or card_type == 'Enhanced' or card.playing_card then
                _suffix = "pcards"
            end

            local _counter = card.ability.kino_numcounters + 1
            if card.ability.kino_numcounters >= 10 then _counter = 10 end

            G["counter_sprites_" .. _suffix][card.ability.kino_counter].role.draw_major = card
            G["counter_sprites_" .. _suffix][card.ability.kino_counter]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G["counter_numbers_" .. _suffix][_counter].role.draw_major = card
            G["counter_numbers_" .. _suffix][_counter]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

-- add counters
Kino.change_counters = function(card, type, num)

    if card and card.ability then
        if card.ability.kino_counter and card.ability.kino_counter ~= type then
            card.ability.kino_numcounters = 0
        end
        card.ability.kino_counter = type
        card.ability.kino_numcounters = card.ability.kino_numcounters or 0
        card.ability.kino_numcounters = card.ability.kino_numcounters + num
        card:juice_up()

        print(card.ability.kino_counter)
        print(card.ability.kino_numcounters)
        if type == "kino_stun" and card.ability.kino_numcounters >= 1 then
            card.kino_was_stunned_this_turn = true
            SMODS.debuff_card(card, true, "kino_stuncounter")
            print("debuffed?")
        end
    end
end

-- Counter mechanics
Kino.investment_counter_effect = function(card)
    ease_dollars(card.ability.kino_numcounters)
    card.ability.kino_numcounters = card.ability.kino_numcounters - 1
end

Kino.debt_counter_effect = function(card)
    ease_dollars(-card.ability.kino_numcounters)
    card.ability.kino_numcounters = card.ability.kino_numcounters - 1
end

Kino.poison_effect = function(card)
    local _percentage = (card.ability.kino_numcounters * 5) / 100
    card.ability.kino_numcounters = card.ability.kino_numcounters - 1
    return {
        chips = -(hand_chips * _percentage),
        mult = -(mult * _percentage),
        message = "-" ..card.ability.kino_numcounters.."%",
        colour = G.C.LEGENDARY
    }
end

Kino.stun_effect = function(card)
    if card.kino_was_stunned_this_turn then
        card.kino_was_stunned_this_turn = false
        return
    end

    card.ability.kino_numcounters = card.ability.kino_numcounters - 1
    if card.ability.kino_numcounters == 0 then
        SMODS.debuff_card(card, false, "kino_stuncounter")
    end
end