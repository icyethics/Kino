function Kino.create_planet_badge(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kino_strange_planet'),
        G.C.KINO.STRANGE_PLANET, G.C.WHITE,
        1.2)
end

-- Gives 30 chips and 3 mult to a random hand.
SMODS.Consumable {
    key = "ego",
    set = "Planet",
    order = 1,
    pos = {x = 0, y = 4},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 5,
            mult = 1,
            a_chips = 1,
            a_mult = 0.2,
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
        local _bonus = 0
        if G.jokers and G.jokers.cards then
            for _index, _joker in ipairs(G.jokers.cards) do
                if string.find(_joker.config.center.key, "guardians_of_the_galaxy") then
                    _bonus = _bonus + 0.25
                end
            end
        end

        return math.min(0.25 + _bonus, 1)
    end,
    use = function(self, card, area, copier)
        
        -- Select random planet
        local _hand = get_random_hand()
        upgrade_hand(card, _hand, card.ability.extra.chips, card.ability.extra.mult)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)

        G.GAME.consumeable_usage_total.kino_ego = G.GAME.consumeable_usage_total.kino_ego or 0
        G.GAME.consumeable_usage_total.kino_ego = G.GAME.consumeable_usage_total.kino_ego + 1
        if G.GAME.consumeable_usage_total.kino_ego >= 5 then
            check_for_unlock({type="kino_ego_usage_20"})
        end

        -- Terraform another consumable
        if G.consumeables and G.consumeables.cards and #G.consumeables.cards > 0 then
            local _valid_targets = {}
            for _index, _cons in ipairs(G.consumeables.cards) do
                if not _cons.ability.eternal and _cons:can_calculate() and not _cons.config.center.immune_to_change then
                    _valid_targets[#_valid_targets + 1] = _cons
                end
            end

            if #_valid_targets > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_ego_planet"))
                        _target:flip()
                        delay(0.1)
                        copy_card(card, _target)
                        if _target == G.P_CENTERS.c_kino_ego then
                            _target.ability.extra.chips = _target.ability.extra.chips + card.ability.extra.a_chips
                            _target.ability.extra.mult = _target.ability.extra.mult + card.ability.extra.a_mult
                            _target.ability.card_limit = card.ability.card_limit or 0
                            _target:flip()
                            _target:juice_up()
                            delay(0.1)
                            card_eval_status_text(_target, 'extra', nil, nil, nil,
                                { message = localize('k_kino_ego_planet'), colour = G.C.LEGENDARY})
                        end
                        return true
                    end
                }))
            end
        end
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- your most played hand gains +mult and +2 * chips equal to its level
SMODS.Consumable {
    key = "pandora",
    set = "Planet",
    order = 2,
    pos = {x = 1, y = 4},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
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
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- Arrakis: double the mult and chips of one of your least played hands.
SMODS.Consumable {
    key = "arrakis",
    set = "Planet",
    order = 3,
    pos = {x = 2, y = 4},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
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
    end,
    set_card_type_badge = Kino.create_planet_badge
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
    pull_button = true,
    strange_planet = true,
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
                new_numerator,
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
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- Cybertron: upgrade a random hand with X0.1 for each time a sci-fi card was upgraded this round.
if kino_config.sci_fi_enhancement then
SMODS.Consumable {
    key = "cybertron",
    set = "Planet",
    order = 5,
    pos = {x = 4, y = 4},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
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
    end,
    set_card_type_badge = Kino.create_planet_badge
}
end

-- LV426. Upgrade your most played hand and debuff two random cards in your deck.
SMODS.Consumable {
    key = "lv426",
    set = "Planet",
    order = 6,
    pos = {x = 5, y = 4},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            debuff_num = 2
        }
    },
    get_weight_mod = function()
        return 0.5
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
        
        check_for_unlock({type = 'kino_lv426_usage'})
    end,
    set_card_type_badge = Kino.create_planet_badge
}


SMODS.Consumable {
    key = "treasure_planet",
    set = "Planet",
    order = 5,
    pos = {x = 1, y = 5},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
        if card.ability.extra.money_seen_non < card.ability.extra.money_threshold then
            return false
        end
		return true
	end,
    config = {
        extra = {
            money_threshold = 10,
            money_seen_non = 0
        }
    },
    get_weight_mod = function()
        return 0.5
    end,
    loc_vars = function(self, info_queue, card)
         local _count = math.floor((card.ability.extra.money_seen_non / card.ability.extra.money_threshold) + 0.5)

        return {
            vars = {
                card.ability.extra.money_threshold,
                card.ability.extra.money_seen_non,
                _count,
            }
        }
    end,
    use = function(self, card, area, copier)
        
        local _count = math.floor((card.ability.extra.money_seen_non / card.ability.extra.money_threshold) + 0.5)
        for i = 1, _count do
            local _hand = get_random_hand()
            local _instant = _count <= 5 and false or true
            SMODS.smart_level_up_hand(nil, _hand, _instant, 1)
        end

    end,
    calculate = function(self, card, context)
        if context.kino_ease_dollars and to_big(context.kino_ease_dollars) < to_big(0) and not context.blueprint then
            card.ability.extra.money_seen_non = card.ability.extra.money_seen_non + (-1 * context.kino_ease_dollars)
            return {
                message = localize("k_kino_treasure_planet_cons"),
                colour = G.C.MONEY
            }
        end
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- Vulcan. Upgrade all hands with +0.5 mult for every discard leftover
SMODS.Consumable {
    key = "vulcan",
    set = "Planet",
    order = 5,
    pos = {x = 2, y = 5},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
		return true
	end,
    
    config = {
        extra = {
            mult = 0.5,
            stacks = 0
        }
    },
    get_weight_mod = function()
        return 0.2
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.stacks
            }
        }
    end,
    use = function(self, card, area, copier)
        
        local _mult = card.ability.extra.mult * card.ability.extra.stacks
        card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_vulcan_use'),  colour = G.C.BLACK })

        update_hand_text(
            { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = _mult, chips = 0, handname = "All Hands", level = "" }
        )
        delay(0.5)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
        
        for _i, _hand in ipairs(G.handlist) do
            upgrade_hand(card, _hand, 0, _mult, 0, 0, true)
        end

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.current_round.discards_left > 0 then
            card.ability.extra.stacks = card.ability.extra.stacks + G.GAME.current_round.discards_left
            return {
                message = "+" .. tostring(G.GAME.current_round.discards_left),
                colour = G.C.MULT
            }
        end
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- Thra: Upgrade a random hand for every unique spell cast while holding this
SMODS.Consumable {
    key = "thra",
    set = "Planet",
    order = 5,
    pos = {x = 3, y = 5},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            list_of_spells = {}
        }
    },
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_fantasy") then
                    enhancement_gate = true
                    break
                end
            end

            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.kino_spellcaster then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,
    get_weight_mod = function()
        return 0.5
    end,
    loc_vars = function(self, info_queue, card)
        local _count = 0

        for i, _spell in pairs(card.ability.extra.list_of_spells) do
            _count = _count + 1
        end
        return {
            vars = {
                _count
            }
        }
    end,
    use = function(self, card, area, copier)
        
        local _count = 0
        for i, _spell in pairs(card.ability.extra.list_of_spells) do
            _count = _count + 1
        end

        for i = 1, _count do
            local _hand = get_random_hand()
            local _instant = _count <= 5 and false or true
            SMODS.smart_level_up_hand(nil, _hand, _instant, 1)
        end

    end,
    calculate = function(self, card, context)
        if context.bb_cast_spell and not card.ability.extra.list_of_spells[context.spell_key] then
            card.ability.extra.list_of_spells[context.spell_key] = true
            return {
                message = "+1",
                colour = G.C.KINO.MAGIC
            }
        end
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- Solaris:
SMODS.Consumable {
    key = "solaris",
    set = "Planet",
    order = 5,
    pos = {x = 4, y = 5},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            stacks = 0
        }
    },
    get_weight_mod = function()
        return 0.1
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks
            }
        }
    end,
    use = function(self, card, area, copier)
        
        -- Flip all jokers back
        for _, joker in ipairs(G.jokers.cards) do
            if joker.facing == 'back' then
                joker:flip()
            end
        end

        -- Set a random hand to the same level as the highest level hand
        local _heighest_level = to_big(1)
        local _invalid_hands = {}

        for _i, _handname in ipairs(G.handlist) do
            local _handlevel = G.GAME.hands[_handname].level
            if _handlevel > _heighest_level then
                _invalid_hands = {}
                _invalid_hands[_handname] = true
                _heighest_level = _handlevel
            elseif _handlevel == _heighest_level then
                _invalid_hands[_handname] = true
            end
        end

        for i = 1, card.ability.extra.stacks do
            -- construct list of valid hands
            local _validhands = {}
            for _i, _handname in ipairs(G.handlist) do
                if not _invalid_hands[_handname] and 
                G.GAME.hands[_handname].visible then
                    _validhands[#_validhands + 1] = _handname
                end
            end
            if #_validhands > 0 then
                local _rand_hand = pseudorandom_element(_validhands, pseudoseed("solaris"))
                _invalid_hands[_rand_hand] = true
                local _difference = _heighest_level - G.GAME.hands[_rand_hand].level

                local _instant = card.ability.extra.stacks <= 5 and false or true
                SMODS.smart_level_up_hand(nil, _rand_hand, _instant, _difference)
            end
            
        end

    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            if #G.jokers.cards > 0 then
                G.jokers:unhighlight_all()
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.facing == 'front' then
                        joker:flip()
                    end
                end
                if #G.jokers.cards > 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    play_sound('cardSlide1', 0.85)
                                    return true
                                end,
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    play_sound('cardSlide1', 1.15)
                                    return true
                                end
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    play_sound('cardSlide1', 1)
                                    return true
                                end
                            }))
                            delay(0.5)
                            return true
                        end
                    }))
                    return {
                        message = localize("k_kino_solaris"),
                        colour = G.C.PLANET
                    }
                end
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.stacks = card.ability.extra.stacks + 1
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.PLANET
            }
        end
    end,
    set_card_type_badge = Kino.create_planet_badge
}


-- Altair 4
SMODS.Consumable {
    key = "altair",
    set = "Planet",
    order = 5,
    pos = {x = 5, y = 5},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
    can_use = function(self, card)
		return true
	end,
    config = {
        extra = {
            chips = 3,
            poison = 2,
            stacks = 0
        }
    },
    get_weight_mod = function()
        return 0.4
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.poison,
                card.ability.extra.stacks
            }
        }
    end,
    use = function(self, card, area, copier)
        
        -- Poison
        for i = 1, card.ability.extra.stacks * card.ability.extra.poison do
            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.playing_cards, {"none", "match"}, "counter_poison")
            
            if #_valid_targets > 0 then
                local _target = pseudorandom_element(_valid_targets, pseudoseed("altair_4"))
                _target:bb_counter_apply("counter_poison", 1)
            end
            
        end

        -- Upgrade
        local _chips = card.ability.extra.chips * card.ability.extra.stacks
        card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_altair4'),  colour = G.C.BLACK })

        update_hand_text(
            { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = _chips, handname = "All Hands", level = "" }
        )
        delay(0.5)
        update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
        )
        
        for _i, _hand in ipairs(G.handlist) do
            upgrade_hand(card, _hand, _chips, 0, 0, 0, true)
        end

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.stacks = card.ability.extra.stacks + 1
            return {
                message = "+" .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end,
    set_card_type_badge = Kino.create_planet_badge
}

-- Death Star: level up every hand once and destroy a joker
SMODS.Consumable {
    key = "death_star",
    set = "Planet",
    order = 7,
    pos = {x = 0, y = 5},
    atlas = "kino_tarot",
    pull_button = true,
    strange_planet = true,
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

        if kino_quality_check(_target, "is_starwars") then
            check_for_unlock({type="kino_destroy_star_wars_with_death_star"})
        end
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
    end,
    set_card_type_badge = Kino.create_planet_badge
}
