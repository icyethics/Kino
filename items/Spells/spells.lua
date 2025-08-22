--- Generate Spell object
Kino.spellSuits = {
    "Hearts",
    "Diamonds",
    "Spades",
    "Clubs"
}

SMODS.Spells = {}
SMODS.Spell = SMODS.Center:extend({
    obj_table = SMODS.Spells,
    obj_buffer = {},
    required_params = {
        "key",
    },
    inject = function() end,
    set = "Spell",
    class_prefix = "spell",
    discovered = true,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_spell'), G.C.PURPLE, G.C.WHITE, 1.2 )
    end,
    cast = function(strength)
        local _obj = SMODS.Spells[self.key]
        G.GAME.current_round.spells_cast = G.GAME.current_round.spells_cast + 1
        G.GAME.current_round.last_spell_cast.key = self.key
        G.GAME.current_round.last_spell_cast.strength = strength
        if _obj and _obj.cast and type(_obj.cast) == 'function' then
            _obj:cast()
        end
        return true
    end
})

SMODS.Spell {
    key = "None_None",
    order = 0,
    atlas = "kino_spells",
    pos = {x = 0, y = 0},
    no_collection = true,
    config = {

    },
    loc_vars = function(self, info_queue, card)

    end,
    cast = function(self, strength)

    end
}

SMODS.Spell {
    key = "Hearts_Hearts",
    order = 1,
    atlas = "kino_spells",
    pos = {x = 0, y = 0},
    config = {
        target = "score",
        mult = {2,3,6,10}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        return {
            mult = self.config.mult[strength]
        }
    end
}

SMODS.Spell {
    key = "Hearts_Diamonds",
    order = 2,
    atlas = "kino_spells",
    pos = {x = 1, y = 0},
    config = {
        target = "score",
        x_mult = {1.1,1.3,1.5,2}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.x_mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        return {
            x_mult = self.config.x_mult[strength]
        }
    end
}

SMODS.Spell {
    key = "Hearts_Clubs",
    order = 3,
    atlas = "kino_spells",
    pos = {x = 2, y = 0},
    config = {
        target = "score",
        mult = {1,2,4,8},
        chips = {3,5,7,9}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.mult
        local _strength_table_2 = self.config.chips
        local _return_target = "ERROR"
        local _return_target_2 = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
            _return_target_2 = _strength_table_2[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["
            _return_target_2 = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|"
                _return_target_2 = _return_target_2 .. _strength_table_2[i] .. "|"  
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
            _return_target_2 = string.sub(_return_target_2 , 1, #_return_target_2-1) .. "]"
        end

        return {
            vars = {
                _return_target,
                _return_target_2
            }
        }
    end,
    cast = function(self, strength)
        return {
            mult = self.config.mult[strength],
            chips = self.config.chips[strength]
        }
    end
}

SMODS.Spell {
    key = "Hearts_Spades",
    order = 4,
    atlas = "kino_spells",
    pos = {x = 3, y = 0},
    config = {
        target = "random card in hand",
        perma_mult = {1,2,3,5}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.perma_mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        local _card = nil
        if G.hand and G.hand.cards and #G.hand.cards > 1 then
            _card = pseudorandom_element(G.hand.cards, pseudoseed("heaspa"))
        end

        if _card then
            _card.ability.perma_mult = _card.ability.perma_mult or 0
            _card.ability.perma_mult = _card.ability.perma_mult + self.config.perma_mult[strength]
        end

        return {
            focus = _card,
            message = localize('k_upgrade_ex'),
            colour = G.C.MULT,
            card = _card
        }
    end
}

SMODS.Spell {
    key = "Diamonds_Diamonds",
    order = 5,
    atlas = "kino_spells",
    pos = {x = 4, y = 0},
    config = {
        target = "score",
        dollars = {1,2,3,5}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.dollars
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        return {
            dollars = self.config.dollars[strength]
        }
    end
}

SMODS.Spell {
    key = "Diamonds_Clubs",
    order = 6,
    atlas = "kino_spells",
    pos = {x = 5, y = 0},
    config = {
        target = "score",
        x_chips = {1.1,1.3,1.5,2}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.x_chips
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        return {
            x_chips = self.config.x_chips[strength]
        }
    end
}

SMODS.Spell {
    key = "Diamonds_Spades",
    order = 7,
    atlas = "kino_spells",
    pos = {x = 0, y = 1},
    config = {
        target = "consumeables",
        consumeable = {"confection", "Planet", "Tarot", "Spectral"}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.consumeable
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        if G.consumeables.config.card_limit - #G.consumeables.cards > 0 then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local _card = create_card(self.config.consumeable[strength], G.consumeables, nil, nil, nil, nil, nil, 'diaspa')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
                return true end }))
            
        end

        return {
            
        }
    end
}

SMODS.Spell {
    key = "Clubs_Spades",
    order = 8,
    atlas = "kino_spells",
    pos = {x = 3, y = 0},
    config = {
        target = "upgrade",
        perma_bonus = {2, 4, 8, 20}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.perma_bonus
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        local _card = nil
        if G.hand and G.hand.cards and #G.hand.cards > 1 then
            _card = pseudorandom_element(G.hand.cards, pseudoseed("heaspa"))
        end

        if _card then
            _card.ability.perma_bonus = _card.ability.perma_bonus or 0
            _card.ability.perma_bonus= _card.ability.perma_bonus + self.config.perma_bonus[strength]
        end

        return {
            focus = _card,
            message = localize('k_upgrade_ex'),
            colour = G.C.CHIPS,
            card = _card
        }
    end
}

SMODS.Spell {
    key = "Clubs_Clubs",
    order = 9,
    atlas = "kino_spells",
    pos = {x = 1, y = 1},
    config = {
        target = "score",
        chips = {5,20,40,100}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.chips
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        return {
            chips = self.config.chips[strength]
        }
    end
}

SMODS.Spell {
    key = "Spades_Spades",
    order = 10,
    atlas = "kino_spells",
    pos = {x = 3, y = 1},
    config = {
        target = "score",
        percentage = {1, 3, 5, 10}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if check_spell_strength(G.hand.cards[3]:get_id())
        local _strength_table = self.config.percentage
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[check_spell_strength(G.hand.cards[3]:get_id())]
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] .. "|" 
            end

            _return_target = string.sub(_return_target , 1, #_return_target-1) .. "]"
        end

        return {
            vars = {
                _return_target
            }
        }
    end,
    cast = function(self, strength)
        G.E_MANAGER:add_event(Event({
            func = (function()
                    G.GAME.blind.chips = G.GAME.blind.chips * (1 - (self.config.percentage[strength] / 100))
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    return true
                    end)
                }))
        return {
            
        }
    end
}

SMODS.Spell {
    key = "EyeOfAgamoto",
    order = 11,
    atlas = "kino_spells",
    pos = {x = 4, y = 1},
    config = {
        target = "unique",
        hands_gained = 2
    },
    loc_vars = function(self, info_queue, card)
        return {
            self.config.hands_gained
        }
    end,
    no_collection = true,
    cast = function(self, strength)
        G.E_MANAGER:add_event(Event({func = function()
            ease_hands_played(self.config.hands_gained)
        return true end }))
        return {
            message = localize('k_drstrange'),
            colour = G.C.GREEN
        }
    end
}


--- Spell related funcs

function cast_spell(spell_key, strength, repeatable)
    if repeatable == nil then
        repeatable = true
    end

    if not SMODS.Spells then
        print("Mod error: no spells to index")
        return {

        }
    end

    SMODS.calculate_context({pre_spell_cast = true, strength = strength, spell_key = spell_key, repeatable = repeatable})

    if #G.GAME.current_round.spell_queue > 0 then
        local _nextspell = G.GAME.current_round.spell_queue[1]
        spell_key = _nextspell.spell_key
        strength = _nextspell.strength
        table.remove(G.GAME.current_round.spell_queue, 1)
    end

    if next(find_joker('j_kino_fantasia')) and strength < 4 then
        strength = strength + 1
    end

    G.GAME.current_round.spells_cast = G.GAME.current_round.spells_cast + 1
    G.GAME.current_round.last_spell_cast.key = spell_key
    G.GAME.current_round.last_spell_cast.strength = strength

    local _return_table = SMODS.Spells[spell_key]:cast(strength)


    SMODS.calculate_context({cast_spell = true, strength = strength, spell_key = spell_key, repeatable = repeatable})

    if type(_return_table) == 'table' then
        return _return_table
    end
    return {

    }
end

function cast_random_base_spell(strength)
    local _base_suits = {'Spades','Hearts','Clubs','Diamonds'}
    local _suit1 = pseudorandom_element(_base_suits, pseudoseed("random_spell"))
    local _suit2 = pseudorandom_element(_base_suits, pseudoseed("random_spell"))

    local _spell_key = "spell_kino_" .. _suit1	.. "_" .. _suit2
    if type(SMODS.Spells[_spell_key]) == "nil" then
        _spell_key = "spell_kino_" .. _suit2	.. "_" .. _suit1
    end
    local _return = {}
    if strength then
        _return = cast_spell(_spell_key, strength)
    else
        local _strength = math.ceil(pseudorandom("random_spell", 0, 4))
        _return = cast_spell(_spell_key, _strength)
    end
    return _return
end

function pick_spell(caster, cards_in_hand, instant)

    -- local _material_1 = cards_in_hand[1].base.suit
    -- local _material_2 = cards_in_hand[2].base.suit
    -- local _material_3 = cards_in_hand[3]:get_id()
    local _strength = check_spell_strength(cards_in_hand[3]:get_id())

    -- local _spell_key = "spell_kino_" .. _material_1	.. "_" .. _material_2
    local _spell_key = check_spell_key(cards_in_hand)
    local _return_table = cast_spell(_spell_key, _strength)

    if not instant then
        G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
            attention_text({
                text = localize({type="name_text", set="Spell", key= _spell_key }),
                scale = 1.3, 
                hold = 1.4,
                major = G.play,
                align = 'tm',
                offset = {x = 0, y = -1},
                silent = true
            })
            caster:juice_up()
        return true end })) 
    end

    if type(_return_table) == 'table' then
        return _return_table
    end

    return true
end

function check_spell_key(cards_in_hand)
    if #cards_in_hand < 3 then
        return "spell_kino_None_None"
    end

    local _material_1 = cards_in_hand[1].base.suit
    local _material_2 = cards_in_hand[2].base.suit

    local _mat1_exists = false
    local _mat2_exists = false
    for _index, _suitkey in ipairs(Kino.spellSuits) do
        if _material_1 == _suitkey then
            _mat1_exists = true
        end
        if _material_2 == _suitkey then
            _mat2_exists = true
        end
    end

    if _mat1_exists == false then
        _material_1 = "Hearts"
    end

    if _mat2_exists == false then
        _material_2 = "Hearts"
    end

    local _spell_key = "spell_kino_" .. _material_1	.. "_" .. _material_2
    if type(SMODS.Spells[_spell_key]) == "nil" then
        _spell_key = "spell_kino_" .. _material_2	.. "_" .. _material_1
    end
    return _spell_key
end

function check_spell_strength(_material_3)
    local _strength = 1

    if _material_3 <= 5 then
        _strength = 1
    end

    if 6 <= _material_3 and _material_3 <= 9 then
        _strength = 2
    end

    if 10 <= _material_3 and _material_3 <= 13 then
        _strength = 3
    end

    if _material_3 == 14 then
        _strength = 4
    end

    return _strength
end

function pick_spell_reverse(caster, cards_in_hand_og, instant)

    -- Reverses cards_in_hand
    local cards_in_hand = {}
    for i = 1, #cards_in_hand_og do
        cards_in_hand[i] = cards_in_hand_og[1 + #cards_in_hand_og - i]
    end

    local _strength = check_spell_strength(cards_in_hand[3]:get_id())

    -- local _spell_key = "spell_kino_" .. _material_1	.. "_" .. _material_2
    local _spell_key = check_spell_key(cards_in_hand)
    local _return_table = cast_spell(_spell_key, _strength)

    if not instant then
        G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
            attention_text({
                text = localize({type="name_text", set="Spell", key= _spell_key }),
                scale = 1.3, 
                hold = 1.4,
                major = G.play,
                align = 'tm',
                offset = {x = 0, y = -1},
                silent = true
            })
            caster:juice_up()
        return true end })) 
    end

    if type(_return_table) == 'table' then
        return _return_table
    end

    return true
end

-- Spell Set up
-- Spells should return:
--  *What they give and the matching value (Mult/Chips/Xmult/Xchips/$)
--  *message
--  *Target of the message

SMODS.UndiscoveredSprite {
    key = "spell",
    atlas = "kino_spells",
    pos = {x = 4, y = 5} 
}