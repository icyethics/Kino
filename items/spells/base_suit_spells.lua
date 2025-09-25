-- Wilds
Blockbuster.Spellcasting.Spell {
    key = "Wild_Wild",
    order = 1,
    atlas = "suit_spells",
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 0},
    config = {
        target = "random_spell",
        strength = {1,2,3,4}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.strength
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Wild",
        "Wild"
    },
    cast = function(self, strength)
        local _available_suits = {}
        for _key, _bool in pairs(Blockbuster.valid_spellsuits) do
            if _key ~= "Wild" then
                _available_suits[#_available_suits + 1] = _key
            end
        end

        local _suit1 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _suit2 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _spellkey = Blockbuster.SuitSpelltable[_suit1][_suit2]
        return Blockbuster.cast_spell(_spellkey, strength)
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Wild_Hearts",
    order = 1,
    atlas = "suit_spells",
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 0},
    config = {
        target = "random_spell",
        strength = {1,2,3,4}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.strength
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Wild",
        "Hearts"
    },
    cast = function(self, strength)
        local _available_suits = {}
        for _key, _bool in pairs(Blockbuster.valid_spellsuits) do
            if _key ~= "Wild" then
                _available_suits[#_available_suits + 1] = _key
            end
        end

        local _suit1 = "Hearts"
        local _suit2 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _spellkey = Blockbuster.SuitSpelltable[_suit1][_suit2]
        return Blockbuster.cast_spell(_spellkey, strength)
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Wild_Diamonds",
    order = 1,
    atlas = "suit_spells",
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 0},
    config = {
        target = "random_spell",
        strength = {1,2,3,4}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.strength
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Wild",
        "Diamonds"
    },
    cast = function(self, strength)
        local _available_suits = {}
        for _key, _bool in pairs(Blockbuster.valid_spellsuits) do
            if _key ~= "Wild" then
                _available_suits[#_available_suits + 1] = _key
            end
        end

        local _suit1 = "Diamonds"
        local _suit2 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _spellkey = Blockbuster.SuitSpelltable[_suit1][_suit2]
        return Blockbuster.cast_spell(_spellkey, strength)
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Wild_Clubs",
    order = 1,
    atlas = "suit_spells",
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 0},
    config = {
        target = "random_spell",
        strength = {1,2,3,4}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.strength
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Wild",
        "Clubs"
    },
    cast = function(self, strength)
        local _available_suits = {}
        for _key, _bool in pairs(Blockbuster.valid_spellsuits) do
            if _key ~= "Wild" then
                _available_suits[#_available_suits + 1] = _key
            end
        end

        local _suit1 = "Clubs"
        local _suit2 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _spellkey = Blockbuster.SuitSpelltable[_suit1][_suit2]
        return Blockbuster.cast_spell(_spellkey, strength)
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Wild_Spades",
    order = 1,
    atlas = "suit_spells",
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 0},
    config = {
        target = "random_spell",
        strength = {1,2,3,4}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.strength
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Wild",
        "Spades"
    },
    cast = function(self, strength)
        local _available_suits = {}
        for _key, _bool in pairs(Blockbuster.valid_spellsuits) do
            if _key ~= "Wild" then
                _available_suits[#_available_suits + 1] = _key
            end
        end

        local _suit1 = "Spades"
        local _suit2 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _spellkey = Blockbuster.SuitSpelltable[_suit1][_suit2]
        return Blockbuster.cast_spell(_spellkey, strength)
    end
}
-- Hearts
Blockbuster.Spellcasting.Spell {
    key = "Hearts_Hearts",
    order = 1,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 0},
    config = {
        target = "score",
        mult = {2,3,6,10}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Hearts",
        "Hearts"
    },
    cast = function(self, strength)
        return {
            mult = self.config.mult[strength]
        }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Hearts_Diamonds",
    order = 2,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 1, y = 0},
    config = {
        target = "score",
        x_mult = {1.1,1.3,1.5,2}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.x_mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Hearts",
        "Diamonds"
    },
    cast = function(self, strength)
        return {
            x_mult = self.config.x_mult[strength]
        }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Hearts_Clubs",
    order = 3,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 2, y = 0},
    config = {
        target = "score",
        mult = {1,2,4,8},
        chips = {3,5,7,9}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.mult
        local _strength_table_2 = self.config.chips
        local _return_target = "ERROR"
        local _return_target_2 = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
            _return_target_2 = _strength_table_2[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Hearts",
        "Clubs"
    },
    cast = function(self, strength)
        return {
            mult = self.config.mult[strength],
            chips = self.config.chips[strength]
        }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Hearts_Spades",
    order = 4,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 3, y = 0},
    config = {
        target = "random card in hand",
        perma_mult = {1,2,3,5}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.perma_mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Hearts",
        "Spades"
    },
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

-- Diamonds
Blockbuster.Spellcasting.Spell {
    key = "Diamonds_Diamonds",
    order = 5,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 4, y = 0},
    config = {
        target = "score",
        dollars = {1,2,3,5}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.dollars
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Diamonds",
        "Diamonds"
    },
    cast = function(self, strength)
        return {
            dollars = self.config.dollars[strength]
        }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Diamonds_Clubs",
    order = 6,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 5, y = 0},
    config = {
        target = "score",
        x_chips = {1.1,1.3,1.5,2}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.x_chips
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Diamonds",
        "Clubs"
    },
    cast = function(self, strength)
        return {
            x_chips = self.config.x_chips[strength]
        }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "Diamonds_Spades",
    order = 7,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 0, y = 1},
    config = {
        target = "consumeables",
        consumeable = {"confection", "Planet", "Tarot", "Spectral"}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.consumeable
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Diamonds",
        "Spades"
    },
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

-- Clubs
Blockbuster.Spellcasting.Spell {
    key = "Clubs_Spades",
    order = 8,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 3, y = 0},
    config = {
        target = "upgrade",
        perma_bonus = {2, 4, 8, 20}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.perma_bonus
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Clubs",
        "Spades"
    },
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

Blockbuster.Spellcasting.Spell {
    key = "Clubs_Clubs",
    order = 9,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 1, y = 1},
    config = {
        target = "score",
        chips = {5,20,40,100}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.chips
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Clubs",
        "Clubs"
    },
    cast = function(self, strength)
        return {
            chips = self.config.chips[strength]
        }
    end
}

-- Spades
Blockbuster.Spellcasting.Spell {
    key = "Spades_Spades",
    order = 10,
    atlas = "suit_spells",
    prefix_config = {key = { mod = false, atlas = false}},
    pos = {x = 3, y = 1},
    config = {
        target = "score",
        percentage = {1, 3, 5, 10}
    },
    loc_vars = function(self, info_queue, card)
        -- If in a blind, then check the hand. Otherwise, do not

        -- if Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())
        local _strength_table = self.config.percentage
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[3]:get_id())]
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
    suit_recipe = {
        "Spades",
        "Spades"
    },
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

-- Suitless