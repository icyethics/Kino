SMODS.Consumable({
    object_type = "Consumable",
    set = "blindability",
    key = "Damsel",
    pos = { x = 0, y = 0 },
    config = {
        max_highlighted = 1,
        extra_slots_used = -1
    },
    cost = 0,
    atlas = "kino_blind_consumables",
    unlocked = true,
    discovered = false,
    can_be_sold = false,
    keep_on_use = function(self, card)
        return true
    end,
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
               card.ability.max_highlighted
            } 
        }
    end,
    use = function(self, card, area, copier)
        local _target = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)

    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)

        if #G.hand.highlighted == 1 and G.hand.highlighted[1]:is_face() then
            return true
        end

		return false
	end,
})