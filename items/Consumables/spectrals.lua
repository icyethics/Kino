if kino_config.actor_synergy then
if not Cryptid then
    SMODS.Consumable {
        key = "award",
        set = "Spectral",
        config = {max_highlighted = 1},
        pos = {x = 0, y = 2},
        atlas = "kino_tarot",
        cost = 4,
        unlocked = true,
        discovered = true,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end,
        can_use = function(self, card)
            return #G.jokers.highlighted == 1
                and Blockbuster.is_value_manip_compatible(G.jokers.highlighted[1])
                and ( not G.jokers.highlighted[1].ability.kino_award or
                G.GAME.used_vouchers.v_kino_egot)
        end,
        use = function(self, card, area, copier)
            SMODS.Stickers['kino_award']:apply(G.jokers.highlighted[1], true)
        end
    }
end
if Cryptid and Talisman then
    SMODS.Consumable {
        key = "award_cryptid",
        set = "Spectral",
        config = {max_highlighted = 1},
        pos = {x = 0, y = 2},
        atlas = "kino_tarot",
        cost = 4,
        unlocked = true,
        discovered = true,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end,
        can_use = function(self, card)
            return #G.jokers.highlighted == 1
                and Blockbuster.is_value_manip_compatible(G.jokers.highlighted[1])
                and ( not G.jokers.highlighted[1].ability.kino_award or
                G.GAME.used_vouchers.v_kino_egot)
        end,
        use = function(self, card, area, copier)
            SMODS.Stickers['kino_award_cryptid']:apply(G.jokers.highlighted[1], true)
        end
    }
end
end

SMODS.Consumable {
    key = "homerun",
    set = "Spectral",
    config = {max_highlighted = 1},
    pos = {x = 1, y = 2},
    atlas = "kino_tarot",
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'kino_sports_seal', set = 'Other'}
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
        play_sound('tarot1')
        return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("kino_sports", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "gathering",
    set = "Spectral",
    config = {max_highlighted = 1},
    pos = {x = 2, y = 2},
    atlas = "kino_tarot",
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'kino_family_seal', set = 'Other'}
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
        play_sound('tarot1')
        return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("kino_family", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "artifact",
    set = "Spectral",
    config = {max_highlighted = 1},
    pos = {x = 3, y = 2},
    atlas = "kino_tarot",
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'kino_adventure_seal', set = 'Other', vars = {0}}
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
        play_sound('tarot1')
        return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("kino_adventure", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "fright",
    set = "Spectral",
    config = {max_highlighted = 3},
    pos = {x = 4, y = 2},
    atlas = "kino_tarot",
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'kino_thriller_seal', set = 'Other', vars = {1, 3}}
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            local conv_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal("kino_thriller", nil, true)
                return true end }))
            
            delay(0.5)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all(); return true
                end
            }))
        end
    end
}

if kino_config.confection_mechanic then
SMODS.Consumable {
    key = "ambrosia",
    set = "Spectral",
    config = {max_highlighted = 1},
    pos = {x = 5, y = 2},
    atlas = "kino_tarot",
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'kino_cheese_seal', set = 'Other'}
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
        play_sound('tarot1')
        return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("kino_cheese", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}
end

SMODS.Consumable {
    key = "whimsy",
    set = "Spectral",
    config = {max_highlighted = 3},
    pos = {x = 0, y = 3},
    atlas = "kino_tarot",
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'kino_comedy_seal', set = 'Other'}
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
        play_sound('tarot1')
        return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("kino_comedy", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}


-- CONFECTION RARE SPECTRAL

-- Permanently increase the power of all confections
SMODS.Consumable {
    key = "ratatouille",
    set = "Spectral",
    order = 10,
    pos = {x = 1, y = 5},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            powerboost = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.powerboost
        if card.ability.kino_chocolate then
            _return = _return + self.config.choco_bonus
        end
        return {
            vars = {
                _return
            }
        } 
    end,
    
    pull_button = true,
    active = false,
    immutable = true,

    hidden = true,
    soul_rate = 0.005,
    soul_set = 'confection',

    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true or (card.area and card.area.config and card.area.config.type == 'shop') then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.config.card_limit)) then
                return true
            else
                return false
            end
                
        end

        return true
	end,
    keep_on_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if card.area ~= G.pack_cards and card.area ~= nil then
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            card.active = true

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true)
        end

        if G.GAME.blind.in_blind then
            local _powerboost = (card.ability.kino_choco and (card.ability.extra.powerboost + card.ability.choco_bonus) or card.ability.extra.powerboost)
            G.GAME.confections_powerboost = G.GAME.confections_powerboost + _powerboost
            

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.setting_blind and card.active then
            local _powerboost = (card.ability.kino_choco and (card.ability.extra.powerboost + card.ability.choco_bonus) or card.ability.extra.powerboost)
            G.GAME.confections_powerboost = G.GAME.confections_powerboost + _powerboost

            Kino.confection_trigger(card)
        end
    end
}