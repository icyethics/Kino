SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "damsel",
    pos = { x = 0, y = 0 },
    config = {
        max_highlighted = 1,
        extra_slots_used = -1,
        extra = {
            lower_by = 25,
            counters_applied = 5
        }
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
               card.ability.max_highlighted,
               card.ability.extra.lower_by,
               card.ability.extra.counters_applied
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
                -- SMODS.destroy_cards(G.hand.highlighted)
                G.hand.highlighted[1]:bb_counter_apply("counter_stun", card.ability.extra.counters_applied)
                Kino.lower_blind(card.ability.extra.lower_by)
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

-- Rattlesnake Jake
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "high_noon",
    pos = { x = 1, y = 0 },
    config = {
        extra_slots_used = -1,
        extra = {
            is_active = true,
            max_removed = 5
        }
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
               card.ability.max_removed,
            } 
        }
    end,
    use = function(self, card, area, copier)
        card.ability.extra.is_active = false

        for _index, _pcard in ipairs(G.hand.highlighted) do
            _pcard:bb_remove_counter("blind_ability")
        end
    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if card.ability.extra.is_active then

            local _count = 0
            for _index, _pcard in ipairs(G.hand.highlighted) do
                _count = _count + (Blockbuster.Counters.get_counter_num(_pcard) or 0)
            end

            if _count <= card.ability.extra.max_removed then
                return true
            end
        end

		return false
	end,
    calculate = function(self, card, context)
        if context.hand_drawn or context.discard then
            card.ability.extra.is_active = true
        end
    end
})

-- Krampus
-- Increase leniency by 1
-- Gain a charge when 5 cards have been discarded
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "list",
    pos = { x = 2, y = 0 },
    config = {
        extra_slots_used = -1,
        extra = {
            is_active = false,
            threshold = 5,
            cards_discarded = 0,
        }
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
               card.ability.extra.threshold,
               card.ability.extra.cards_discarded,
               1
            } 
        }
    end,
    use = function(self, card, area, copier)
        card.ability.extra.is_active = false
        card.ability.extra.cards_discarded = card.ability.extra.cards_discarded - card.ability.extra.threshold

        G.GAME.current_round.krampus_cards = math.max(G.GAME.current_round.krampus_cards - 1, 0)
    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if card.ability.extra.is_active and
        G.GAME.current_round.krampus_cards and G.GAME.current_round.krampus_cards > 0 then
            return true
        end

		return false
	end,
    calculate = function(self, card, context)
        if context.discard then
            card.ability.extra.cards_discarded = card.ability.extra.cards_discarded + 1
            if card.ability.extra.cards_discarded >= 5 then
                card.ability.extra.is_active = true
            end
        end
    end,
})


-- Electro
-- Increase leniency by 1
-- Gain a charge when 5 cards have been discarded
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "lightning_rod",
    pos = { x = 3, y = 0 },
    config = {
        extra_slots_used = -1,
        extra = {
            is_active = false,
            charges = 0,
        }
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
               card.ability.extra.charges,
               1
            } 
        }
    end,
    use = function(self, card, area, copier)
        local _target = G.hand.highlighted[1]

        local _counter_types = {}
        local _counter_total = 0

        for i = 1, card.ability.extra.charges do
            local _valid_targets = {}
            for _index, _joker in ipairs(G.jokers.cards) do
                local _num = (Blockbuster.Counters.get_counter_num(_joker) or 0)
                if _num > 0 then
                    _valid_targets[#_valid_targets + 1] = _joker
                end
            end
            if #_valid_targets > 0 then 
                local _joker_target = pseudorandom_element(_valid_targets, pseudoseed("kino_rod"))
                _joker_target:bb_increment_counter(-1)
                _counter_types[#_counter_types + 1] = Blockbuster.Counters.get_counter(_joker_target)
                _counter_total = _counter_total + 1
            end
        end

        local _counter = pseudorandom_element(_counter_types, pseudoseed("kino_rod_counter"))
        _target:bb_counter_apply(_counter, _counter_total)
        card.ability.extra.charges = 0
    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if #G.hand.highlighted == 1 and card.ability.extra.charges > 0 then
            if (Blockbuster.Counters.get_counter_num(G.hand.highlighted[1]) or 0) == 0 then
                return true 
            end
        end

		return false
	end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            card.ability.extra.charges = card.ability.extra.charges + (#context.hand_drawn * 2)
        end
    end,
})


-- Te Ka
-- Increase leniency by 1
-- Put a Burn counter on selected joker, or double them
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "eruption",
    pos = { x = 4, y = 0 },
    config = {
        extra_slots_used = -1,
        extra = {
        }
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

            } 
        }
    end,
    use = function(self, card, area, copier)
        if G.GAME.current_round.te_ka_play_selection_removed > 0 then
            G.GAME.current_round.te_ka_play_selection_removed = G.GAME.current_round.te_ka_play_selection_removed - 1
            SMODS.change_play_limit(1)
        end

        if G.GAME.current_round.te_ka_discard_selection_removed > 0 then
            G.GAME.current_round.te_ka_discard_selection_removed = G.GAME.current_round.te_ka_discard_selection_removed - 1
            SMODS.change_discard_limit(1)
        end
        
        local _num = (Blockbuster.Counters.get_counter_num(G.jokers.highlighted[1]) or 0) 
        if _num == 0 then
            G.jokers.highlighted[1]:bb_counter_apply("counter_burn", 1)
        else
            local _counter = Blockbuster.Counters.get_counter(G.jokers.highlighted[1])
            G.jokers.highlighted[1]:bb_counter_apply(_counter, _num)
        end
        
    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if #G.jokers.highlighted == 1 and 
        G.GAME.current_round.te_ka_discard_selection_removed > 0 and
        G.GAME.current_round.te_ka_play_selection_removed > 0 then
            return true 
        end

		return false
	end
})


-- Poppy Adams
-- Spend half your money to halve the number of poison counters in your deck
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "cure",
    pos = { x = 5, y = 0 },
    config = {
        extra_slots_used = -1,
        extra = {
            cost = 1
        }
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
        local _total = {counter_values = 0}
        if G.playing_cards then
            _total = Blockbuster.Counters.get_total_counters("counter_poison", "Full Deck")
        end
        return { 
            vars = { 
                card.ability.extra.cost,
                _total.counter_values
            } 
        }
    end,
    use = function(self, card, area, copier)
        ease_dollars(-1 * card.ability.extra.cost)
        local _total = Blockbuster.Counters.get_total_counters("counter_poison", "Full Deck")

        local _counters_to_remove = math.ceil(_total.counter_values / 2)

        for i = 1, _counters_to_remove do
            local _validtargets = Blockbuster.Counters.get_counter_targets(G.playing_cards, {"match"}, "counter_poison")
            local _target = pseudorandom_element(_validtargets, pseudoseed("kino_poppy"))
            _target:bb_increment_counter(-1, nil, true)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.cost = math.max(math.floor(G.GAME.dollars / 2), 1)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if Blockbuster.Counters.get_total_counters("counter_poison", "Full Deck").counter_values > 0 then
            return true 
        end

		return false
	end
})


-- Poppy Adams
-- Spend half your money to halve the number of poison counters in your deck
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "defibrillator",
    pos = { x = 0, y = 1 },
    config = {
        extra_slots_used = -1,
        extra = {
            is_active = true
        }
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
            } 
        }
    end,
    use = function(self, card, area, copier)
        local _target = G.jokers.highlighted[1]
        local _total = Blockbuster.Counters.get_counter_num(_target)
        card.ability.extra.is_active = false
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        
        _target:bb_remove_counter("blind_ability")

        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                _target:bb_counter_apply("counter_paralysis", _total)
                return true
            end
        }))
    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if #G.jokers.highlighted == 1 and
        Blockbuster.Counters.is_counter(G.jokers.highlighted[1], "counter_sleep") and
        card.ability.extra.is_active then
            return true 
        end

		return false
	end,
    calculate = function(self, card, context)
        if context.hand_drawn or context.discard then
            card.ability.extra.is_active = true
        end
    end
})


-- Ghost Rider
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "penance_stare",
    pos = { x = 2, y = 1 },
    config = {
        max_highlighted = 1,
        extra_slots_used = -1,
        extra = {
        }
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

            } 
        }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
                func = function()
                    local _target = G.hand.highlighted[1]
                    local _num = (Blockbuster.Counters.get_counter_num(_target) or 0) 
                    if _num == 0 then
                        _target:bb_counter_apply("counter_kino_chain", 1)
                    else
                        _target:bb_counter_apply("counter_kino_chain", _num)
                    end

                    for _index, _pcard in ipairs(G.playing_cards) do
                        if _pcard ~= _target and Blockbuster.Counters.is_counter_of_class(_pcard, {"detrimental"}) then
                            local _lower = false
                            if _pcard:get_id() == _target:get_id() then
                                _lower = true
                            else 
                                if not SMODS.has_no_suit(_pcard) and not
                                SMODS.has_no_suit(_target) then
                                    if (SMODS.has_any_suit(_pcard) or SMODS.has_any_suit(_target))
                                    or _pcard.config.card.suit == _target.config.card.suit then
                                        _lower = true
                                    end
                                end
                            end

                            if _lower then
                                _pcard:bb_increment_counter(-1)
                            end
                        end
                    end
                    return true
                end
            }))
        delay(0.3)
        return {
            message = "Fire!",
            colour = G.C.RED
        }

    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if #G.hand.highlighted == 1 and 
        Blockbuster.Counters.is_counter(G.hand.highlighted[1], "counter_kino_chain") then
            return true
        end
        return false
	end,
})

-- Godzilla
SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "barrage",
    pos = { x = 1, y = 1 },
    config = {
        max_highlighted = 1,
        extra_slots_used = -1,
        extra = {
        }
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

            } 
        }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
                    func = function()
                        local _hand_selection_limit = G.GAME.starting_params.play_limit
                        SMODS.change_discard_limit(100)
                        for _, playing_card in ipairs(G.hand.cards) do
                            G.hand:add_to_highlighted(playing_card, true)
                        end
                        G.FUNCS.discard_cards_from_highlighted(nil, true)
                        SMODS.change_discard_limit(-100)
                        return true
                    end
                }))
        delay(0.3)
        return {
            message = "Fire!",
            colour = G.C.RED
        }

    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)

        return true
	end,
})

-- Slot Canyon

SMODS.Consumable({
    object_type = "Consumable",
    set = "BlindAbility",
    key = "drastic_measure",
    pos = { x = 3, y = 1 },
    config = {
        max_highlighted = 1,
        extra_slots_used = -1,
        extra = {
        }
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

            } 
        }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.jokers.highlighted[1]:start_dissolve()
                ease_hands_played(1)
                return true
            end
        }))

    end,
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
    can_use = function(self, card)
        if #G.jokers.highlighted == 1 then
            return true
        end
        return false
	end,
})