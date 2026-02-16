
SMODS.Blind{
    key = "scorpionking",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("8a6848"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 6},
    debuff = {
        counter_type = "Drought"
    },
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type then
            return true
        end

        return false
    end,
    loc_vars = function(self)
        return {
            vars = {

            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {

            }
        }
    end,
    disable = function(self)

    end,
    defeat = function(self)

    end,
    calculate = function(self, blind, context)
        -- Whenever a card scores, put a poison counter on all cards held in hand
        if context.individual and context.cardarea == "unscored" and not context.end_of_round then
            context.other_card:bb_counter_apply("counter_kino_drought", 3)
            
            return {
                message = "Bwaaah!",
                card = context.other_card,
            }
        end
    end
}

SMODS.Blind{
    key = "imhotep",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("a29c8f"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 7},
    debuff = {
        counter_type = "Drought"
    },
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type then
            return true
        end

        return false
    end,
    loc_vars = function(self)
        return {
            vars = {
                localize(G.GAME.current_round.imhotep_suit, 'suits_plural'),
                colours = {
                    G.C.SUITS[G.GAME.current_round.imhotep_suit]
                }
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                localize("Hearts", 'suits_plural'),
                colours = {
                    G.C.SUITS["Hearts"]
                }
            }
        }
    end,
    disable = function(self)

    end,
    defeat = function(self)

    end,
    set_blind = function(self)
        for _index, _pcard in ipairs(G.playing_cards) do
            if _pcard:is_suit(G.GAME.current_round.imhotep_suit) then
                _pcard:bb_counter_apply("counter_kino_drought", 1)
            end
        end

    end,
    calculate = function(self, blind, context)
    end
}

SMODS.Blind{
    key = "rattlesnake_jake",
    dollars = 7,
    mult = 2,
    boss_colour = HEX("808a6d"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 8},
    debuff = {
        counter_type = "Drought"
    },
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type and
        (4 <= math.max(1, G.GAME.round_resets.ante)) then
            return true
        end

        return false
    end,
    loc_vars = function(self)
        return {
            vars = {

            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {

            }
        }
    end,
    disable = function(self)

    end,
    defeat = function(self)
        for _index, _consumable in ipairs(G.consumeables.cards) do
            if _consumable.ability.set == "BlindAbility" then
                _consumable:start_dissolve()
            end
        end
        return true
    end,
    set_blind = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_high_noon", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
    calculate = function(self, blind, context)
        if context.hand_drawn then
            local _count = 0
            for _index, _pcard in ipairs(G.hand.cards) do
                _count = _count + (Blockbuster.Counters.get_counter_num(_pcard) or 0)
            end

            local _counters_to_apply = math.max(10 - _count, 0)
            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.hand.cards, {"none", "match", "no_match_class"}, "counter_kino_drought", {"beneficial"})
            for i = 1, _counters_to_apply do
                local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_rattlesnake_jake"))
                _target:bb_counter_apply("counter_kino_drought", 1)
            end
        end
    end
}