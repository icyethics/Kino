SMODS.Blind{
    key = "jacob_morley",
    dollars = 4,
    mult = 2,
    boss_colour = HEX("b1bcbe"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 20},
    debuff = {
        counter_type = "Chain"
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
        G.GAME.current_round.jacob_morley_suits = {}
    end,
    set_blind = function(self)
        G.GAME.current_round.jacob_morley_suits = {}
    end,
    calculate = function(self, blind, context)
        -- Put a Fire counter on every 5th card drawn
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                local _target = context.hand_drawn[i]
                local _suits = SMODS.Suits
                local _apply_chain = false

                for _suitname, _suitdata in pairs(_suits) do
                    if _target:is_suit(_suitname) then
                        G.GAME.current_round.jacob_morley_suits[_suitname] = G.GAME.current_round.jacob_morley_suits[_suitname] or 0
                        G.GAME.current_round.jacob_morley_suits[_suitname] = G.GAME.current_round.jacob_morley_suits[_suitname] + 1

                        if G.GAME.current_round.jacob_morley_suits[_suitname] >= 3 then
                            G.GAME.current_round.jacob_morley_suits[_suitname] = G.GAME.current_round.jacob_morley_suits[_suitname] - 3
                            _apply_chain = true
                        end
                    end
                end
                
                if _apply_chain then
                    _target:bb_counter_apply("counter_kino_chain", 2)
                    card_eval_status_text(_target, 'extra', nil, nil, nil,
                    { message = localize("k_kino_morley"), colour = HEX("b1bcbe")})
                end
            end
        end
    end
}

SMODS.Blind{
    key = "clubber",
    dollars = 4,
    mult = 2,
    boss_colour = HEX("47919f"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 21},
    debuff = {
        counter_type = "Chain"
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

        if context.pre_discard then
            local _hasspoken = false
            for _index, _pcard in ipairs(G.hand.cards) do
                local _is_highlighted = false
                _pcard:juice_up()
                for _index2, _highlighted_pcard in ipairs(G.hand.highlighted) do
                    if _pcard == _highlighted_pcard then
                        _is_highlighted = true
                    end
                end

                if _is_highlighted == false then
                    _pcard:bb_counter_apply("counter_kino_chain", 1)
                    if not _hasspoken then
                        card_eval_status_text(_pcard, 'extra', nil, nil, nil,
                        { message = localize("k_kino_clubber"), colour = HEX("b1bcbe")}) 
                        _hasspoken = true
                    end
                    
                end
            end
        end
    end
}

SMODS.Blind{
    key = "ghost_rider",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("b1bcbe"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 22},
    debuff = {
        counters_applied = 4,
        counter_type = "Chain"
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
                self.debuff.counters_applied
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                self.debuff.counters_applied
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
        for _index, _pcard in ipairs(G.playing_cards) do
            _pcard:bb_counter_apply("counter_kino_chain", self.debuff.counters_applied, nil, true)
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_penance_stare", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
}