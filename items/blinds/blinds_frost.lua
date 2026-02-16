
SMODS.Blind{
    key = "elsa",
    dollars = 5,
    mult = 2,
    boss_colour = G.C.KINO.KINO_FROST_LIGHT,
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 1},
    debuff = {
        counter_type = "Frost"
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
        local _valid_targets = Blockbuster.Counters.get_counter_targets(G.jokers.cards, {"none", "match", "no_match_class"}, "counter_frost", {"beneficial"})
        for i = 1, 10 do
            local _target = pseudorandom_element(_valid_targets)
            _target:bb_counter_apply("counter_frost", 1)
        end
    end,
}

SMODS.Blind{
    key = "jacktorrance",
    dollars = 5,
    mult = 2,
    boss_colour = G.C.KINO.KINO_FROST_DARK,
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 2},
    debuff = {
        counter_type = "Frost"
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
        -- Whenever a card scores, put a poison counter on all cards held in hand
        if context.individual and context.cardarea == G.play and not context.end_of_round then
            local _targets = {}
            for _index, _pcard in ipairs(G.deck.cards) do
                if _pcard:get_id() == context.other_card:get_id() then
                    _targets[#_targets + 1] = _pcard
                end
            end

            local _valid_targets = Blockbuster.Counters.get_counter_targets(_targets, {"none", "match", "no_match_class"}, "counter_frost", {"beneficial"})
            for i = 1, 2 do
                local _target = pseudorandom_element(_valid_targets)
                if _target then
                    _target:bb_counter_apply("counter_frost", 1)
                end
                
            end
            
            if #_targets > 0 then
                return {
                    message = "Brrr",
                    card = context.other_card,
                    colour = G.C.KINO.KINO_FROST_LIGHT
                }
            end
        end
    end
}

SMODS.Blind{
    key = "krampus",
    dollars = 7,
    mult = 2,
    boss_colour = HEX("4f6367"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 5},
    debuff = {
        counter_type = "Frost"
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
                G.GAME.current_round.krampus_cards or 5
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                5
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
        G.GAME.current_round.krampus_cards = 5
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_list", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
    calculate = function(self, blind, context)
        -- Whenever a card scores, put a poison counter on all cards held in hand
        if context.before then

            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.jokers.cards, {"none", "match", "no_match_class"}, "counter_frost", {"beneficial"})
            
            local _times_to_trigger = G.GAME.current_round.krampus_cards - #context.scoring_hand
            for i = 1, _times_to_trigger do
                local _target = pseudorandom_element(_valid_targets)
                if _target then
                    _target:bb_counter_apply("counter_frost", 5)
                end
                
            end
            
            if _times_to_trigger > 0 then
                return {
                    message = localize("k_polar_express_bad"),
                    card = context.other_card,
                    colour = G.C.KINO.KINO_FROST_LIGHT
                }
            end
        end
    end
}