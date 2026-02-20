SMODS.Blind{
    key = "freddy_krueger",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("aa5858"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 16},
    debuff = {
        chance = 2,
        counter_type = "Sleep"
    },
    in_pool = function(self)
        if G.GAME.current_round.boss_blind_selection_1 == self.debuff.counter_type or
        G.GAME.current_round.boss_blind_selection_2 == self.debuff.counter_type then
            return true
        end

        return false
    end,
    loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, self.debuff.chance, "kino_boss_blind")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                1,
                2
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
        -- Put a Drowsy Counter on a random joker if a 5 or lower is drawn
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                if context.hand_drawn[i]:get_id() <= 5 then
                    if SMODS.pseudorandom_probability(self, 'kino_freddy_krueger', 1, self.debuff.chance, "kino_boss_blind") then   
                        local _valid_targets = Blockbuster.Counters.get_counter_targets(G.jokers.cards, {"none", "match", "no_match_class"}, "counter_drowsy", {"beneficial"})
                        local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_freddy"))
                        _target:bb_counter_apply("counter_drowsy", 1)
                        card_eval_status_text(context.hand_drawn[i], 'extra', nil, nil, nil,
                        { message = localize("k_kino_freddy"), colour = G.C.BLACK})
                    end
                end
            end
        end
    end
}

SMODS.Blind{
    key = "rose_the_hat",
    dollars = 5,
    mult = 2,
    boss_colour = HEX("9ae4e7"),
    atlas = 'kino_blinds_2', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 17},
    debuff = {
        counter_type = "Sleep"
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
        local _enhanced_count = 0
        for _index, _pcard in ipairs(G.playing_cards) do
            if _pcard.config.center ~= G.P_CENTERS.c_base then
                _enhanced_count = _enhanced_count + 1
            end
        end

        for i = 1, _enhanced_count do
            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.jokers.cards, {"none", "match", "no_match_class"}, "counter_drowsy", {"beneficial"})
            local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_rose_the_hat"))
            _target:bb_counter_apply("counter_drowsy", 1)
            card_eval_status_text(_target, 'extra', nil, nil, nil,
            { message = localize("k_kino_rose"), colour = G.C.BLACK})
        end

    end,
    calculate = function(self, blind, context)

    end
}

SMODS.Blind{
    key = "flatline",
    dollars = 7,
    mult = 2,
    boss_colour = HEX("74db6c"),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10},
    pos = { x = 0, y = 15},
    debuff = {
        min_counters = 1,
        max_counters = 4,
        counter_type = "Sleep"
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
        for _index, _joker in ipairs(G.jokers.cards) do
            local _num = pseudorandom("kino_flatline", 1, 4)
            _joker:bb_counter_apply("counter_sleep", _num)
            card_eval_status_text(_joker, 'extra', nil, nil, nil,
            { message = localize("k_kino_flatline"), colour = G.C.BLACK})
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_defibrillator", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
}