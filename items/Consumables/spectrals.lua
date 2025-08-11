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
                and G.jokers.highlighted[1].config.center.kino_joker
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