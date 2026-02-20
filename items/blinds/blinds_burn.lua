SMODS.Blind{
    key = "ronald_bartel",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("9c4b4c"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 12},
    debuff = {
        counter_type = "Burn"
    },
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
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type then
            return true
        end

        return false
    end,
    set_blind = function(self)
        G.GAME.current_round.bartel_triggers = 0
    end,
    calculate = function(self, blind, context)
        -- Put a Fire counter on every 5th card drawn
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                G.GAME.current_round.bartel_triggers = G.GAME.current_round.bartel_triggers + 1
                if G.GAME.current_round.bartel_triggers >= 5 then
                    G.GAME.current_round.bartel_triggers = 0
                    context.hand_drawn[i]:bb_counter_apply("counter_burn", 1)
                    card_eval_status_text(context.hand_drawn[i], 'extra', nil, nil, nil,
                    { message = localize("k_kino_bartel"), colour = G.C.RED})
                end
            end
        end
    end
}

SMODS.Blind{
    key = "varang",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("c25d5d"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 10},
    debuff = {
        counter_type = "Burn"
    },
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
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type then
            return true
        end

        return false
    end,
    disable = function(self)

    end,
    defeat = function(self)

    end,
    set_blind = function(self)
        G.GAME.current_round.varang_triggers = 5
    end,
    calculate = function(self, blind, context)
        -- Put a Fire counter on the first 5 cards played or discarded
        if context.individual and context.cardarea == G.play and not context.end_of_round and
        G.GAME.current_round.varang_triggers > 0 then
            
            context.other_card:bb_counter_apply("counter_burn", 1)
            G.GAME.current_round.varang_triggers = G.GAME.current_round.varang_triggers - 1
            return {
                message = "Fire",
                card = context.other_card,
                colour = G.C.RED
            }
        end

        if context.pre_discard and
        G.GAME.current_round.varang_triggers > 0 then
            
            for _index, _pcard in ipairs(context.full_hand) do
                if G.GAME.current_round.varang_triggers > 0 then
                    _pcard:bb_counter_apply("counter_burn", 1)
                    G.GAME.current_round.varang_triggers = G.GAME.current_round.varang_triggers - 1

                    card_eval_status_text(_pcard, 'extra', nil, nil, nil,
                    { message = "Fire", colour = G.C.RED})
                end
            end
        end
    end
}

SMODS.Blind{
    key = "te_ka",
    dollars = 7,
    mult = 2,
    boss_colour = HEX("714f4f"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 11},
    debuff = {
        counter_type = "Burn"
    },
    loc_vars = function(self)
        return {
            vars = {
                G.GAME.current_round.te_ka_selection_size or 2
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                2
            }
        }
    end,
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type  and
        (4 <= math.max(1, G.GAME.round_resets.ante)) then
            return true
        end

        return false
    end,
    disable = function(self)

    end,
    defeat = function(self)
        SMODS.change_play_limit(G.GAME.current_round.te_ka_play_selection_removed)

        SMODS.change_discard_limit(G.GAME.current_round.te_ka_discard_selection_removed)

        for _index, _consumable in ipairs(G.consumeables.cards) do
            if _consumable.ability.set == "BlindAbility" then
                _consumable:start_dissolve()
            end
        end
        return true
    end,
    set_blind = function(self)
        G.GAME.current_round.te_ka_selection_size = 2
        local _adjust_by = G.GAME.starting_params.play_limit - G.GAME.current_round.te_ka_selection_size
        G.GAME.current_round.te_ka_play_selection_removed = _adjust_by
        SMODS.change_play_limit(-_adjust_by)

        local _adjust_by = G.GAME.starting_params.discard_limit - G.GAME.current_round.te_ka_selection_size
        G.GAME.current_round.te_ka_discard_selection_removed = _adjust_by
        SMODS.change_discard_limit(-_adjust_by)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_eruption", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
}