-- Gives 30 chips and 3 mult to a random hand.
SMODS.Consumable {
    key = "ego",
    set = "Planet",
    order = 1,
    pos = {x = 0, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 30,
            mult = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    get_weight_mod = function()
        return 0.5
    end,
    use = function(self, card, area, copier)
        -- Select random planet
        local _hand = get_random_hand()
        upgrade_hand(card, _hand, card.ability.extra.chips, card.ability.extra.mult)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
    end
}

-- your most played hand gains +mult and +2 * chips equal to its level
SMODS.Consumable {
    key = "pandora",
    set = "Planet",
    order = 2,
    pos = {x = 1, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
            }
        }
    end,
    get_weight_mod = function()
        return 0.3
    end,
    use = function(self, card, area, copier)

        local _hand, _tally = nil, -1

		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end

        upgrade_hand(card, _hand, card.ability.extra.chips * _tally , 0)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
    end
}

-- Arrakis: double the mult and chips of one of your least played hands.
SMODS.Consumable {
    key = "arrakis",
    set = "Planet",
    order = 3,
    pos = {x = 2, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            x_mult = 2,
            x_chips = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.x_chips,
            }
        }
    end,
    in_pool = function(self, args)
        local _hands = {}
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible and G.GAME.hands[v].played ~= 0 then
                _hands[#_hands + 1] = v

            end
        end

        if #_hands > 3 then
            return true
        else
            return false
        end
    end,
    get_weight_mod = function()
        return 0.5
    end,
    use = function(self, card, area, copier)

        local _hands = get_least_played_hand()
        local _hand =  pseudorandom_element(_hands, pseudoseed("arrakis"))

        card_eval_status_text(card, 'extra', nil, nil, nil,
        { message = localize('k_arrakis'),  colour = G.C.BLACK })

        upgrade_hand(card, _hand, 0, 0, card.ability.extra.x_chips, card.ability.extra.x_mult)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
    end
}

-- Krypton: level up your most played hand once for each level it has.
-- 1/100 chance to reset it back to 1 instead. double the chance whenever you use
-- krypton
SMODS.Consumable {
    key = "krypton",
    set = "Planet",
    order = 4,
    pos = {x = 3, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chance_cur = 1,
            a_chance = 2,
            chance_max = 25,
        }
    },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1 * (2 ^ (G.GAME.current_round.kryptons_used - 1)), card.ability.extra.chance_max, "kino_card_debuff")
        return {
            vars = {
                math.min(new_numerator),
                new_denominator,
                G.GAME.current_round.kryptons_used
            }
        }
    end,
    get_weight_mod = function()
        return 0.1
    end,
    use = function(self, card, area, copier)

        local _hand, _tally = nil, -1

		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played > _tally) then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end

        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
            handname=localize(_hand, 'poker_hands'),
            chips = G.GAME.hands[_hand].chips, 
            mult = G.GAME.hands[_hand].mult, 
            level=G.GAME.hands[_hand].level
        })

        -- if pseudorandom("krypton") < (((G.GAME.probabilities.normal + 1 ) * (2 ^ (G.GAME.current_round.kryptons_used - 1))) / card.ability.extra.chance_max) then
        if SMODS.pseudorandom_probability(self, 'kino_krypton', 1 * (2 ^ (G.GAME.current_round.kryptons_used - 1)), card.ability.extra.chance_max, "kino_card_debuff") then    
            level_up_hand(card, _hand, nil, (-1 * G.GAME.hands[_hand].level) + 1)
        else
            level_up_hand(card, _hand, nil, G.GAME.hands[_hand].level)
        end

        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )

        G.GAME.current_round.kryptons_used = G.GAME.current_round.kryptons_used + 1
    end
}

-- Cybertron: upgrade a random hand with X0.1 for each time a sci-fi card was upgraded this round.
if kino_config.sci_fi_enhancement then
SMODS.Consumable {
    key = "cybertron",
    set = "Planet",
    order = 5,
    pos = {x = 4, y = 4},
    atlas = "kino_tarot",
    enhancement_gate = "m_kino_sci_fi",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            x_mult = 0.25
        }
    },
    get_weight_mod = function()
        return 0.25
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                1 + G.GAME.current_round.sci_fi_upgrades_last_round * card.ability.extra.x_mult
            }
        }
    end,
    use = function(self, card, area, copier)

        local _hand = get_random_hand()
        local _x_mult = G.GAME.current_round.sci_fi_upgrades_last_round * card.ability.extra.x_mult
        upgrade_hand(card, _hand, 0, 0, 0, _x_mult)

        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
    end
}
end

-- LV426. Upgrade your most played hand and debuff two random cards in your deck.
SMODS.Consumable {
    key = "lv426",
    set = "Planet",
    order = 6,
    pos = {x = 5, y = 4},
    atlas = "kino_tarot",
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            debuff_num = 2
        }
    },
    get_weight_mod = function()
        return 0.8
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.debuff_num
            }
        }
    end,
    use = function(self, card, area, copier)

        -- Find most played hand
        local _hand, _tally = nil, -1

		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played > _tally) then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end

        for i = 1, card.ability.extra.debuff_num do
            local _card = nil
            local _found_target = false
            while not _found_target do
                _card = pseudorandom_element(G.deck.cards)
                if not _card.debuff then
                    _found_target = true
                end
            end
                
            SMODS.debuff_card(_card, true, card.config.center.key)
        end

        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
            handname=localize(_hand, 'poker_hands'),
            chips = G.GAME.hands[_hand].chips, 
            mult = G.GAME.hands[_hand].mult, 
            level=G.GAME.hands[_hand].level
        })
        level_up_hand(card, _hand, nil, 1)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
    end
}

-- Death Star: level up every hand once and destroy a joker
SMODS.Consumable {
    key = "death_star",
    set = "Planet",
    order = 7,
    pos = {x = 0, y = 5},
    atlas = "kino_tarot",
    can_use = function(self, card)
        local _eligible_targets = {}

        for _, _joker in ipairs(G.jokers.cards) do
            if _ > 1 and not SMODS.is_eternal(_joker, {death_star = true}) then
                _eligible_targets[#_eligible_targets + 1] = _joker
            end
        end

        if #_eligible_targets > 0 then return true end
		return false
	end,
    config = {
        extra = {
            
        }
    },
    get_weight_mod = function()
        return 0.2
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    use = function(self, card, area, copier)

        -- Find most played hand
        local _eligible_targets = {}

        for _, _joker in ipairs(G.jokers.cards) do
            if _ > 1 and not SMODS.is_eternal(_joker, {death_star = true}) then
                _eligible_targets[#_eligible_targets + 1] = _joker
            end
        end

        -- destroy random joker
        local _target = pseudorandom_element(_eligible_targets, pseudoseed("kino_death_star"))
        -- local _target = G.jokers.cards[1]
        _target.getting_sliced = true
        _target:start_dissolve()

        for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v] then
				level_up_hand(card, v, true, 1)
			end
		end

        
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "All Hands", level = "+1" }
        )
        delay(0.5)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
    end
}