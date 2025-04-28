-- Most confections create a tag when used in specific contents.

-- Upgrade the next hand you play with +2 mult
SMODS.Consumable {
    key = "popcorn",
    set = "confection",
    order = 1,
    pos = {x = 0, y = 0},
    atlas = "kino_confections",
    config = {
        choco_mult = 1,
        extra = {
            active = false,
            times_used = 0,
            mult = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.mult
        if card.ability.kino_chocolate then
            _return = _return + self.config.choco_mult
        end
        return {
            
            vars = {
                _return
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _mult = card.ability.kino_choco and (card.ability.extra.mult + card.ability.choco_mult) or card.ability.extra.mult
            upgrade_hand(nil, context.scoring_name, 0, _mult)
            Kino.confection_trigger(card)
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
            chips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _chips = card.ability.kino_choco and (card.ability.extra.chips + card.ability.choco_bonus) or card.ability.extra.chips
            upgrade_hand(nil, context.scoring_name, _chips, 0)
            Kino.confection_trigger(card)
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
            hand_size = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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

            local _hand_size = card.ability.kino_choco and (card.ability.extra.hand_size + card.ability.choco_bonus) or card.ability.extra.hand_size
            G.hand:change_size(_hand_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + _hand_size

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.first_hand_drawn and card.active then
            local _hand_size = card.ability.kino_choco and (card.ability.extra.hand_size + card.ability.choco_bonus) or card.ability.extra.hand_size
            G.hand:change_size(_hand_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + _hand_size
            Kino.confection_trigger(card)
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
            extra = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.extra
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _interest = card.ability.kino_choco and (card.ability.extra.extra + card.ability.choco_mult) or card.ability.extra.extra
            G.GAME.interest_amount = G.GAME.interest_amount + _interest

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true)
        end

    end,
    calculate = function(self, card, context)
        if context.enter_shop and card.active then
            local _interest = card.ability.kino_choco and (card.ability.extra.extra + card.ability.choco_mult) or card.ability.extra.extra
            G.GAME.interest_amount = G.GAME.interest_amount - _interest
            Kino.confection_trigger(card)
        end
    end
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
        return {
            vars = {
                card.ability.extra.repetition 
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
                if context.card.config.card.suit == card.ability.extra.suits[i] then
                    _is_viable = false
                    break
                end 
            end

            if _is_viable and 
            context.card.config.center ~= G.P_CENTERS.m_stone then
                
                if card.ability.kino_goldleaf then
                    ease_dollars(1)
                end
                card.ability.extra.suits[#card.ability.extra.suits + 1] = context.card.config.card.suit

                local _repetitions = card.ability.kino_choco and (card.ability.extra.repetition + card.ability.choco_bonus) or card.ability.extra.repetition 

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
            repetition = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetition 
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
                
                if card.ability.kino_goldleaf then
                    ease_dollars(1)
                end

                local _repetitions = card.ability.kino_choco and (card.ability.extra.repetition + card.ability.choco_bonus) or card.ability.extra.repetition

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
        choco_bonus = 1,
        extra = {
            active = false,
            times_used = 0,
            cards_drawn = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_drawn
            }
        } 
    end, 
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _cards_drawn = card.ability.kino_choco and (card.ability.extra.cards_drawn + card.ability.choco_mult) or card.ability.extra.cards_drawn
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_eaten'), colour = G.C.MULT})
                G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
                delay(0.23)
            return true end }))

            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            Kino.confection_trigger(card)
        end
    end,
    calculate = function(self, card, context)

        if context.hand_drawn and card.active then
            local _cards_drawn = card.ability.kino_choco and (card.ability.extra.cards_drawn + card.ability.choco_mult) or card.ability.extra.cards_drawn
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_eaten'), colour = G.C.MULT})
                G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
                delay(0.23)
            return true end }))

            if card.ability.kino_goldleaf then
                ease_dollars(1)
            end

            Kino.confection_trigger(card)
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
        choco_bonus = 5,
        extra = {
            times_used = 0,
            bonus_chips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus_chips
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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

        if context.individual and context.scoring_hand[1] and card.active then
            local _chips = card.ability.kino_choco and (card.ability.extra.bonus_chips + card.ability.choco_bonus) or card.ability.extra.bonus_chips
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + _chips 
            Kino.confection_trigger(card)
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
        return {
            vars = {
                card.ability.extra.level
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _level = card.ability.kino_choco and (card.ability.extra.level + card.ability.choco_bonus) or card.ability.extra.level
            level_up_hand(card, context.scoring_name, nil, _level)
            Kino.confection_trigger(card)
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
        return {
            vars = {
                card.ability.extra.hands
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _hands = card.ability.kino_choco and (card.ability.extra.hands + card.ability.choco_bonus) or card.ability.extra.hands

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
            discards = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discards
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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
            local _discards = card.ability.kino_choco and (card.ability.extra.discards + card.ability.choco_bonus) or card.ability.extra.discards

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
    end
}

Kino.confection_trigger = function(card)
    card_eval_status_text(card, 'extra', nil, nil, nil,
    { message = localize('k_eaten'), colour = G.C.MULT})

    if card.ability.kino_goldleaf then
        ease_dollars(1)
    end

    card.ability.extra.times_used = card.ability.extra.times_used + 1
    SMODS.calculate_context({confection_used = true, other_confection = card, times_used = card.ability.extra.times_used})

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
                card:start_dissolve()
                return true
            end)
        }))
    end
end

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
                #Kino.snackbag.cards
            }
        }
    end,
    use = function(self, card, area, copier)
        if Kino.snackbag then
            Kino.snackbag.states.visible = not Kino.snackbag.states.visible
        end
    end
}

