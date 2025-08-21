-- -- Draws counters
-- -- SMODS.DrawStep {
-- --     key = "kino_counter_draw",
-- --     order = 71,
-- --     func = function(card, layer)
-- --         if card and card.ability.kino_counter and 
-- --         card.ability.kino_numcounters > 0 then
-- --             local card_type = card.ability.set
-- --             local _suffix = "jokers"
-- --             if card_type == 'Default' or card_type == 'Enhanced' or card.playing_card then
-- --                 _suffix = "pcards"
-- --             end

-- --             local _counter = card.ability.kino_numcounters + 1
-- --             if card.ability.kino_numcounters >= 10 then _counter = 10 end

-- --             G["counter_sprites_" .. _suffix][card.ability.kino_counter].role.draw_major = card
-- --             G["counter_sprites_" .. _suffix][card.ability.kino_counter]:draw_shader('dissolve', nil, nil, nil, card.children.center)
-- --             G["counter_numbers_" .. _suffix][_counter].role.draw_major = card
-- --             G["counter_numbers_" .. _suffix][_counter]:draw_shader('dissolve', nil, nil, nil, card.children.center)
-- --         end
-- --     end,
-- --     conditions = {vortex = false, facing = 'front'}
-- -- }

-- -- add counters
-- Kino.change_counters = function(card, type, num)

--     if card and card.ability then
--         if card.ability.kino_counter and card.ability.kino_counter ~= type then
--             card.ability.kino_numcounters = 0
--         end
--         card.ability.kino_counter = type
--         card.ability.kino_numcounters = card.ability.kino_numcounters or 0
--         card.ability.kino_numcounters = card.ability.kino_numcounters + num
--         if card.ability.kino_numcounters > 9 then 
--             card.ability.kino_numcounters = 9
--         end

--         local _curcount = card.ability.kino_numcounters
--         card:juice_up()

--         if type == "kino_stun" and card.ability.kino_numcounters >= 1 and
--         num > 0 then
--             card.kino_was_stunned_this_turn = true
--             SMODS.debuff_card(card, true, "kino_stuncounter")
--         end

--         if type == "kino_power" and card.ability.kino_numcounters >= 1 and
--         num > 0 then
--             card.kino_was_powered_this_turn = true
--             card:set_multiplication_bonus(card, "kino_powercounter", 2)
--         end

--         if type == "kino_chained" and card.ability.kino_numcounters >= 1 and
--         num > 0 then
--             card.kino_was_chained_this_turn = true
--             card.ability.cannot_be_discarded = true
--         end

--         -- Visual indicator updating
--         G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
--             card.ability.kino_numcounters = _curcount
--         return true end }))
--     end
-- end


-- -- Counter mechanics
-- Kino.investment_counter_effect = function(card)
--     ease_dollars(card.ability.kino_numcounters)
--     card.ability.kino_numcounters = card.ability.kino_numcounters - 1
--     if card.ability.kino_numcounters <= 0 then
--         card.ability.kino_numcounters = 0
--         card.ability.kino_counter = nil
--     end
-- end

-- Kino.power_counter_effect = function(card)
--     if card.kino_was_powered_this_turn then
--         card.kino_was_powered_this_turn = nil
--         return
--     end
--     G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
--         card:juice_up()
--         card.ability.kino_numcounters = card.ability.kino_numcounters - 1
--         if card.ability.kino_numcounters <= 0 then
--             card:set_multiplication_bonus(card, "kino_powercounter", 1, nil, 1 + 1)
--             card.ability.kino_numcounters = 0
--             card.ability.kino_counter = nil
--         end
--     return true end }))
-- end

-- Kino.debt_counter_effect = function(card)
--     ease_dollars(-card.ability.kino_numcounters)
--     card.ability.kino_numcounters = card.ability.kino_numcounters - 1
--     if card.ability.kino_numcounters <= 0 then
--         card.ability.kino_numcounters = 0
--         card.ability.kino_counter = nil
--     end
-- end

-- Kino.poison_effect = function(card)
--     local _percentage = to_big((card.ability.kino_numcounters * 5) / 100)
--     card.ability.kino_numcounters = card.ability.kino_numcounters - 1
--     if card.ability.kino_numcounters <= 0 then
--         card.ability.kino_numcounters = 0
--         card.ability.kino_counter = nil
--     end
--     return {
--         chips = to_number(-(hand_chips * _percentage)),
--         mult = to_number(-(mult * _percentage)),
--         message = "-" ..to_number(card.ability.kino_numcounters).."%",
--         colour = G.C.LEGENDARY
--     }
-- end

-- Kino.stun_effect = function(card)
--     if card.kino_was_stunned_this_turn then
--         card.kino_was_stunned_this_turn = nil
--         return
--     end
--     SMODS.calculate_context({kino_counter_effect = true, kino_counter_type = "kino_stun", kino_counter_down = true, other_card = card})
--     G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
--         card:juice_up()
--         card.ability.kino_numcounters = card.ability.kino_numcounters - 1
        
--         if card.ability.kino_numcounters <= 0 then
--             SMODS.debuff_card(card, false, "kino_stuncounter")
--             card.ability.kino_numcounters = 0
--             card.ability.kino_counter = nil
--         end
--     return true end }))
-- end

-- Kino.chain_effect = function(card)
--     if card.kino_was_chained_this_turn then
--         card.kino_was_chained_this_turn = nil
--         return
--     end

--     card:juice_up()

--     if card.ability.kino_numcounters <= 0 then
--         card.ability.cannot_be_discarded = false
--     end
--     card.ability.kino_numcounters = card.ability.kino_numcounters - 1
    
-- end