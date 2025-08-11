if Cryptid and Talisman and kino_config.confection_mechanic then
-- Upgrade the next hand you play with +2 mult
SMODS.Consumable {
    key = "mam",
    set = "confection",
    order = 100,
    pos = {x = 0, y = 1},
    atlas = "kino_cryptid_consumables",
    config = {
        choco_bonus = 1,
        extra = {
            active = false,
            times_used = 0,
            jollies = 1
        }
    },
    dependencies = {
		items = {
			"set_cry_m",
			"banana",
		},
	},
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.jollies + G.GAME.confections_powerboost
        if card.ability.kino_chocolate then
            _return = _return + self.config.choco_bonus
        end

        if _return >= 200 then _return = 200 end
        return {
            
            vars = {
                _return
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true or (card.area and card.area.config and card.area.config.type == 'shop') then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and Kino.snackbag and Kino.snackbag.cards and #Kino.snackbag.cards < Kino.snackbag.cards.card_limit)) then
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

        if context.after and card.active then
            local _ranks = {}
            for _, _card in ipairs(G.play.cards) do
                local _rank1 = _card:get_id()

                if not _ranks[_rank1] then
                    _ranks[_rank1] = 0
                end
                _ranks[_rank1] = _ranks[_rank1] + 1

            end

            local _triggers = 0
            for _rank, _count in pairs(_ranks) do
                if _count >= 2 then

                    _triggers = (_triggers + card.ability.extra.jollies) + G.GAME.confections_powerboost
                    if card.ability.kino_chocolate then
                        _triggers= _triggers + card.ability.choco_bonus
                    end
                end
            end

            for i = 1, math.min(200, math.floor(_triggers)) do
				local jolly_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_jolly")
                jolly_card:set_banana(true)
				jolly_card:set_edition({negative = true}, true)
                jolly_card:add_to_deck()
				G.jokers:emplace(jolly_card)
			end
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

SMODS.Consumable {
    key = "nutrition",
    set = "confection",
    order = 101,
    pos = {x = 1, y = 1},
    atlas = "kino_cryptid_consumables",
    config = {
        choco_bonus = 0.1,
        extra = {
            active = false,
            times_used = 0,
            powerboost = 0.2
        }
    },
    dependencies = {
		items = {

		},
	},
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.powerboost + G.GAME.confections_powerboost
        if card.ability.kino_chocolate then
            _return = _return + self.config.choco_bonus
        end
        return {
            
            vars = {
                _return * 100
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true or (card.area and card.area.config and card.area.config.type == 'shop') then
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
            if G.jokers and G.jokers.cards and G.jokers.cards[1] then
                local _target = G.jokers.cards[1]
                _target:juice_up()
                if _target:can_calculate() then
                    local _multiplier = _target:get_multiplier_by_source(_target, "kino_nutrition") or 1
                    
                    local _addition = card.ability.extra.powerboost + G.GAME.confections_powerboost
                    if card.ability.kino_chocolate then
                        _addition = _addition + card.ability.choco_bonus
                    end

                    _multiplier = _multiplier + _addition

                    _target:set_multiplication_bonus(_target, "kino_nutrition", _multiplier)
                end
            end
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}

SMODS.Consumable {
    key = "monster_energy",
    set = "confection",
    order = 102,
    pos = {x = 2, y = 1},
    atlas = "kino_cryptid_consumables",
    config = {
        choco_bonus = 1,
        extra = {
            active = false,
            times_used = 0,
            retriggers = 2,
            target = nil,
            debug_var = 0
        }
    },
    dependencies = {
		items = {

		},
	},
    loc_vars = function(self, info_queue, card)
        local _return = card.ability.extra.retriggers + G.GAME.confections_powerboost
        if card.ability.kino_chocolate then
            _return = _return + self.config.choco_bonus
        end

        if _return > 25 then _return = 25 end
        return {
            
            vars = {
                _return
            }
        } 
    end,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true or (card.area and card.area.config and card.area.config.type == 'shop') then
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

        if (card.area == G.consumeables or
        card.area == Kino.snackbag) and
        G.jokers and G.jokers.cards and #G.jokers.cards < 1 then
            return false
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

            -- select card
            local _joker = pseudorandom_element(G.jokers.cards, pseudoseed('monster_energy'))
            _joker.marked_by_monster = card.ID

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true, 0.05)
        end
    end,
    calculate = function(self, card, context)

        if context.before and card.active then
            -- card.ability.extra.target = pseudorandom_element(G.jokers.cards, pseudoseed('monster_energy'))
            
        end

        if card.active
        and context.retrigger_joker_check and 
        not context.retrigger_joker and context.other_card ~= self then

            local _total_retriggers = card.ability.extra.retriggers + G.GAME.confections_powerboost
            if card.ability.kino_chocolate then
                _total_retriggers = _total_retriggers + card.ability.choco_bonus
            end

            if context.other_card.marked_by_monster == card.ID then
                card.ability.extra.has_retriggered = true
                context.other_card.marked_by_monster = nil
                return {
					message = localize("k_again_ex"),
					repetitions = math.min(25, _total_retriggers),
					card = card,
				}
			else
				return nil, true
			end
		end

        if context.after and card.ability.extra.has_retriggered == true then
            card.ability.extra.has_retriggered = false
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _index, _joker in ipairs(G.jokers.cards) do
            if _joker.marked_by_monster == card.ID then
                _joker.marked_by_monster = nil
            end
        end
    end
}
end