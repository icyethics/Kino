if kino_config.confection_mechanic then
-- Upgrade the next hand you play with +2 mult
SMODS.Consumable {
    key = "popcorn",
    set = "confection",
    order = 1,
    pos = {x = 0, y = 0},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            active = false,
            times_used = 0,
            mult = 4
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.mult + G.GAME.confections_powerboost
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
            juice_card_until(card, eval, true, 0.05)
        end
    end,
    calculate = function(self, card, context)

        if context.before and card.active then
            local _mult = (card.ability.kino_choco and (card.ability.extra.mult + card.ability.choco_bonus) or card.ability.extra.mult) + G.GAME.confections_powerboost
            upgrade_hand(nil, context.scoring_name, 0, _mult)
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Upgrade the next hand you play with +10 chips
SMODS.Consumable {
    key = "icecream",
    set = "confection",
    order = 2,
    pos = {x = 1, y = 0},
    atlas = "kino_confections",
    config = {
        choco_bonus = 5,
        extra = {
            times_used = 0,
            chips = 20
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.chips + G.GAME.confections_powerboost
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
    end,
    calculate = function(self, card, context)

        if context.before and card.active then
            local _chips = (card.ability.kino_choco and (card.ability.extra.chips + card.ability.choco_bonus) or card.ability.extra.chips) + G.GAME.confections_powerboost
            upgrade_hand(nil, context.scoring_name, _chips, 0)
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Gain +1 hand size until the end of this round
SMODS.Consumable {
    key = "candy",
    set = "confection",
    order = 3,
    pos = {x = 2, y = 0},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            hand_size = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.hand_size + G.GAME.confections_powerboost
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
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            card.active = true

            local _hand_size = (card.ability.kino_choco and (card.ability.extra.hand_size + card.ability.choco_bonus) or card.ability.extra.hand_size) + G.GAME.confections_powerboost
            G.hand:change_size(_hand_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + _hand_size

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.first_hand_drawn and card.active then
            local _hand_size = (card.ability.kino_choco and (card.ability.extra.hand_size + card.ability.choco_bonus) or card.ability.extra.hand_size) + G.GAME.confections_powerboost
            G.hand:change_size(_hand_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + _hand_size
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Double the interest this round
SMODS.Consumable {
    key = "peanuts",
    set = "confection",
    order = 4,
    pos = {x = 3, y = 0},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            interest_raised_by = {2},
            times_used = 0,
            extra = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.extra + G.GAME.confections_powerboost
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
            local _interest = (card.ability.kino_choco and (card.ability.extra.extra + card.ability.choco_bonus) or card.ability.extra.extra) + G.GAME.confections_powerboost
            G.GAME.interest_amount = G.GAME.interest_amount + _interest
            card.ability.extra.interest_raised_by[1] = _interest

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true)
        end

    end,
    calculate = function(self, card, context)
        if context.kino_enter_shop and card.active then
            G.GAME.interest_amount = G.GAME.interest_amount - card.ability.extra.interest_raised_by[1]
            Kino.confection_trigger(card)

        end
        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if card.active then
            G.GAME.interest_amount = G.GAME.interest_amount - card.ability.extra.interest_raised_by[1]
        end
	end,
}

-- Retrigger the first card of each suit a second time this round.
SMODS.Consumable {
    key = "pizza",
    set = "confection",
    order = 5,
    pos = {x = 4, y = 0},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            repetition = 1,
            suits = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.repetition + G.GAME.confections_powerboost
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
    end,
    calculate = function(self, card, context)

        if context.cardarea == G.play and context.repetition and not context.repetition_only 
        and card.active then

            -- Check for suits already encountered
            local _is_viable = true
            for i = 1, #card.ability.extra.suits do
                if context.other_card.config.card.suit == card.ability.extra.suits[i] then
                    _is_viable = false
                    break
                end 
            end

            if _is_viable and 
            context.other_card.config.center ~= G.P_CENTERS.m_stone then
                
                card.ability.extra.suits[#card.ability.extra.suits + 1] = context.other_card.config.card.suit

                local _repetitions = (card.ability.kino_choco and (card.ability.extra.repetition + card.ability.choco_bonus) or card.ability.extra.repetition) + G.GAME.confections_powerboost

                return {
                    card = context.card,
                    effect = nil,
                    repetitions = _repetitions,
                    message = localize('k_again_ex')
                }
            end
        end

        if context.after and card.active then
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- retrigger the first scoring card twice
SMODS.Consumable {
    key = "soda",
    set = "confection",
    order = 6,
    pos = {x = 5, y = 0},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            repetition = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.repetition + G.GAME.confections_powerboost
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
    end,
    calculate = function(self, card, context)

        
        if context.cardarea == G.play and context.repetition and not context.repetition_only 
        and card.active then
            if context.scoring_hand[1] == context.other_card then

                local _repetitions = (card.ability.kino_choco and (card.ability.extra.repetition + card.ability.choco_bonus) or card.ability.extra.repetition) + G.GAME.confections_powerboost

                return {
                    card = context.card,
                    effect = nil,
                    repetitions = _repetitions,
                    message = localize('k_again_ex')
                }
            end
        end

        if context.after and card.active then
            Kino.confection_trigger(card)
        end
        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Draw 2 cards.
SMODS.Consumable {
    key = "chocolate_bar",
    set = "confection",
    order = 7,
    pos = {x = 0, y = 1},
    atlas = "kino_confections",
    config = {
        choco_bonus = 2,
        extra = {
            active = false,
            times_used = 0,
            cards_drawn = 4
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.cards_drawn + G.GAME.confections_powerboost
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
            local _cards_drawn = (card.ability.kino_choco and (card.ability.extra.cards_drawn + card.ability.choco_bonus) or card.ability.extra.cards_drawn) + G.GAME.confections_powerboost
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_eaten'), colour = G.C.MULT})
                G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
                delay(0.23)
            return true end }))

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.hand_drawn and card.active then
            local _cards_drawn = (card.ability.kino_choco and (card.ability.extra.cards_drawn + card.ability.choco_bonus) or card.ability.extra.cards_drawn) + G.GAME.confections_powerboost
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_eaten'), colour = G.C.MULT})
                G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
                delay(0.23)
            return true end }))

            Kino.confection_trigger(card)
        end
        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Upgrade the next scoring card with +10 chips
SMODS.Consumable {
    key = "fries",
    set = "confection",
    order = 8,
    pos = {x = 1, y = 1},
    atlas = "kino_confections",
    config = {
        choco_bonus = 25,
        extra = {
            times_used = 0,
            bonus_chips = 25
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.bonus_chips + G.GAME.confections_powerboost
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
    end,
    calculate = function(self, card, context)

        if context.individual and context.scoring_hand and context.scoring_hand[1] and card.active then
            local _chips = (card.ability.kino_choco and (card.ability.extra.bonus_chips + card.ability.choco_bonus) or card.ability.extra.bonus_chips) + G.GAME.confections_powerboost
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + _chips 
            Kino.confection_trigger(card)
        end

        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- level up the next hand played
SMODS.Consumable {
    key = "hotdog",
    set = "confection",
    order = 9,
    pos = {x = 2, y = 1},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            level = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.level + G.GAME.confections_powerboost
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
    end,
    calculate = function(self, card, context)

        if context.before and card.active then
            local _level = (card.ability.kino_choco and (card.ability.extra.level + card.ability.choco_bonus) or card.ability.extra.level) + G.GAME.confections_powerboost
            level_up_hand(card, context.scoring_name, nil, _level)
            Kino.confection_trigger(card)
        end

        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Gain +1 hand this round.
SMODS.Consumable {
    key = "cookie",
    set = "confection",
    order = 10,
    pos = {x = 3, y = 1},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            hands = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.hands + G.GAME.confections_powerboost
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
            local _hands = (card.ability.kino_choco and (card.ability.extra.hands + card.ability.choco_bonus) or card.ability.extra.hands) + G.GAME.confections_powerboost

            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_hands_played(_hands)
                    return true
                end)
            }))

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.setting_blind and card.active then
            local _hands = card.ability.kino_choco and (card.ability.extra.hands + card.ability.choco_bonus) or card.ability.extra.hands

            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_hands_played(_hands)
                    return true
                end)
            }))

            Kino.confection_trigger(card)
        end

        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Gain +1 discard this round.

SMODS.Consumable {
    key = "gum",
    set = "confection",
    order = 10,
    pos = {x = 4, y = 1},
    atlas = "kino_confections",
    config = {
        choco_bonus = 1,
        extra = {
            times_used = 0,
            discards = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.discards + G.GAME.confections_powerboost
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
            local _discards = (card.ability.kino_choco and (card.ability.extra.discards + card.ability.choco_bonus) or card.ability.extra.discards) + G.GAME.confections_powerboost

            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_discard(_discards)
                    return true
                end)
            }))

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.setting_blind and card.active then
            local _discards = card.ability.kino_choco and (card.ability.extra.discards + card.ability.choco_bonus) or card.ability.extra.discards

            G.E_MANAGER:add_event(Event({
                func = (function()
                    ease_discard(_discards)
                    return true
                end)
            }))

            Kino.confection_trigger(card)
        end

        
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

-- Permanently increase the power of all confections
SMODS.Consumable {
    key = "ratatouille",
    set = "confection",
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

SMODS.Consumable {
    key = "snackbag",
    set = "confection",
    order = 98,
    pos = {x = 0, y = 5},
    atlas = "kino_confections",
    hidden = true,
    can_be_sold = false,
    is_snackbag = true,
    soul_rate = 0,
    can_use = function(self, card)
        return true
	end,
    keep_on_use = function(self, card)
        return true
    end,
    config = {
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                Kino.snackbag and Kino.snackbag.cards and #Kino.snackbag.cards or 0
            }
        }
    end,
    use = function(self, card, area, copier)
        if Kino.snackbag then
            Kino.snackbag.states.visible = not Kino.snackbag.states.visible
        end
    end,
    calculate = function(self, card, context)
        if (context.joker_type_destroyed or context.selling_card) and Kino.snackbag then
            if context.card.area == Kino.snackbag then
                if #Kino.snackbag.cards <= 1 then
                card:start_dissolve()
                Kino.snackbag.states.visible = false
                end
            end
        end
    end
}

end