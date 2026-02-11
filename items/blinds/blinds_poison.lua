SMODS.Blind{
    key = "pgande",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('529cb7'),
    atlas = 'kino_blinds', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 32},
    debuff = {
        counter_type = "Poison"
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
        if context.after then
            for _index, _pcard in ipairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                    blind:wiggle()
                    _pcard:bb_counter_apply("counter_poison", 2)
                return true end }))
            end
        end
    end
}

SMODS.Blind{
    key = "evilqueen",
    dollars = 4,
    mult = 2,
    boss_colour = HEX("4d754d"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 13},
    debuff = {
        counter_type = "Poison"
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
        if context.after then

            local _valid_targets = Blockbuster.Counters.get_counter_targets(context.scoring_hand, {"none", "match", "no_match_class"}, "counter_poison", {"beneficial"})
            
            local _times_to_trigger = 5 - #context.scoring_hand
            for i = 1, #_valid_targets do
                local _target = _valid_targets[i]
                if _target then
                    _target:bb_counter_apply("counter_poison", _times_to_trigger)
                end
                
            end
            
            if _times_to_trigger > 0 then
                return {
                    message = localize("k_kino_evilqueen"),
                    card = context.other_card,
                    colour = G.C.GREEN
                }
            end
        end
    end
}

SMODS.Blind{
    key = "poppy_adams",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("fbf236"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 14},
    debuff = {
        counter_type = "Poison"
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
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_cure", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))

        local _valid_targets = Blockbuster.Counters.get_counter_targets(G.playing_cards, {"none", "match", "no_match_class"}, "counter_poison", {"beneficial"})
        for i = 1, 100 do
            local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_poppy_adams"))
            _target:bb_counter_apply("counter_poison", 1)
        end
    end,
    calculate = function(self, blind, context)
        if context.hand_drawn then
            local _count = 0
            for _index, _pcard in ipairs(G.hand.cards) do
                _count = _count + (Blockbuster.Counters.get_counter_num(_pcard) or 0)
            end

            local _counters_to_apply = math.max(10 - _count, 0)
        end
    end
}