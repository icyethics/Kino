
SMODS.Blind{
    key = "zeus",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("667e8e"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 3},
    debuff = {
        counter_type = "Shock"
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
    set_blind = function(self)

    end,
    calculate = function(self, blind, context)
        if context.post_trigger and
        not context.other_context.destroying_card then
            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.deck.cards, {"none", "match", "no_match_class"}, "counter_frost", {"beneficial"})
            local _target = pseudorandom_element(_valid_targets)
            if _target then
                _target:bb_counter_apply("counter_paralysis", 1)
                return {
                    message = "*BOOM*",
                    card = context.other_card,
                    colour = HEX("9c9a35")
                }
            end
            
        end
    end
}

SMODS.Blind{
    key = "cable_guy",
    dollars = 3,
    mult = 2,
    boss_colour = HEX("667e8e"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 4},
    debuff = {
        counter_type = "Shock"
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
    set_blind = function(self)

    end,
    calculate = function(self, blind, context)
         if context.after and G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.jokers.cards, {"none", "match", "no_match_class"}, "counter_frost", {"beneficial"})

            for _index, _target in ipairs(_valid_targets) do
                _target:bb_counter_apply("counter_paralysis", 2)
                card_eval_status_text(_target, 'extra', nil, nil, nil,
                { message = "*ZAP*", colour = HEX("9c9a35")})
            end
            
        end
    end
}


SMODS.Blind{
    key = "electro",
    dollars = 3,
    mult = 2,
    boss_colour = HEX("667e8e"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 9},
    debuff = {
        counter_type = "Shock"
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
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_lightning_rod", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))

        local _valid_targets = Blockbuster.Counters.get_counter_targets(G.jokers.cards, {"none", "match", "no_match_class"}, "counter_paralysis", {"beneficial"})
        for _index, _target in ipairs(_valid_targets) do
            _target:bb_counter_apply("counter_paralysis", 10)
        end
    end,
    calculate = function(self, blind, context)

    end
}