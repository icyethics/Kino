Blockbuster.Spellcasting.Spell {
    key = "EyeOfAgamoto",
    order = 16,
    atlas = "kino_non_suit_spells",
    pos = {x = 4, y = 0},
    config = {
        target = "unique",
        hands_gained = 2
    },
    loc_vars = function(self, info_queue, card)
        return {
            self.config.hands_gained
        }
    end,
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


-- Evil Spells
-- X0.4 Mult, X0.6 Mult, X0.8, X0.9
Blockbuster.Spellcasting.Spell {
    key = "evil_Hearts",
    order = 16,
    atlas = "kino_non_suit_spells",
    pos = {x = 4, y = 0},
    no_collection = true,
    config = {
        target = "unique",
        mult = {0.4, 0.6, 0.8, 0.9}
    },
    loc_vars = function(self, info_queue, card)
        local _strength_table = self.config.mult
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 2 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[2]:get_id())]
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
            x_mult = self.config.mult[strength],
        }
    end
}

-- evil diamonds
-- set money to 0%, 50%, 75%, 90%
Blockbuster.Spellcasting.Spell {
    key = "evil_Diamonds",
    order = 16,
    atlas = "kino_non_suit_spells",
    pos = {x = 4, y = 0},
    no_collection = true,
    config = {
        target = "unique",
        money = {1, 0.5, 0.25, 0.1}
    },
    loc_vars = function(self, info_queue, card)
        local _strength_table = self.config.money
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 2 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[2]:get_id())] * 100
        else
            _return_target = "["

            for i = 1, #_strength_table do
                _return_target = _return_target .. _strength_table[i] * 100 .. "|" 
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
        local _money = (G.GAME.dollars + (G.GAME.dollar_buffer or 0))
        local _moneylost = _money * self.config.money[strength]
        return {
            dollars = -_moneylost,
            colour = G.C.MONEY
        }
    end
}

-- evil Spades
-- increase blind requirement by [50%, 30%, 20%, 5%]
Blockbuster.Spellcasting.Spell {
    key = "evil_Spades",
    order = 16,
    atlas = "kino_non_suit_spells",
    pos = {x = 4, y = 0},
    no_collection = true,
    config = {
        target = "unique",
        blind = {50, 30, 20, 5}
    },
    loc_vars = function(self, info_queue, card)
        local _strength_table = self.config.blind
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 2 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[2]:get_id())]
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


        Kino.lower_blind(-1 * self.config.blind[strength])
        return {
            message = localize("k_kino_evil_spades"),
            colour = G.C.SPADES
        }
    end
}

-- Evil Clubs
-- lower Chips by
Blockbuster.Spellcasting.Spell {
    key = "evil_Clubs",
    order = 16,
    atlas = "kino_non_suit_spells",
    pos = {x = 4, y = 0},
    no_collection = true,
    config = {
        target = "unique",
        chips = {0.4, 0.6, 0.8, 0.9}
    },
    loc_vars = function(self, info_queue, card)
        local _strength_table = self.config.chips
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 2 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[2]:get_id())]
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
            x_chips = self.config.chips[strength],
        }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "evil_Wild",
    order = 16,
    atlas = "kino_non_suit_spells",
    pos = {x = 4, y = 0},
    no_collection = true,
    config = {
        target = "unique",
        
    },
    loc_vars = function(self, info_queue, card)
        local _strength_table = self.config.chips
        local _return_target = "ERROR"
        if G.hand and G.hand.cards and #G.hand.cards >= 2 then
            _return_target = _strength_table[Blockbuster.id_to_spell_level(G.hand.cards[2]:get_id())]
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
        local _available_suits = {"Hearts", "Spades", "Clubs", "Diamonds"}

        local _suit1 = pseudorandom_element(_available_suits, pseudoseed("bb_wildspell_wild"))
        local _spellkey = "spell_kino_evil_" .. _suit1
        return KBlockbuster.cast_spell(_spellkey, strength)
    end
}

    