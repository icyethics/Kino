SMODS.Blind{
    key = "thanos",
    dollars = 8,
    mult = 2,
    boss_colour = HEX('815e88'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10, showdown = true},
    pos = { x = 0, y = 30},
    debuff = {

    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    set_blind = function(self)
        -- separate all cards into two buckets
        local _tempCards = {}

        for _, _pcard in ipairs(G.playing_cards) do
            _tempCards[_] = _pcard
            _pcard.ability.thanos_pool = false
        end

        for i = 1, #_tempCards / 2 do
            local chosen, index = pseudorandom_element(_tempCards, pseudoseed("kinoblind_thanos"))
            chosen.ability.thanos_pool = true
            table.remove(_tempCards, index)
        end

    end,
    press_play = function(self)
       

    end,
    calculate = function(self, blind, context)
        if context.after then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_kino_blind_thanos'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = G.play,
                    align = 'tm',
                    offset = {x = 0, y = -1},
                    silent = true
                })
                blind:wiggle()
                for _, _pcard in ipairs(G.playing_cards) do
                    SMODS.recalc_debuff(_pcard)
                end
            return true end }))
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card and type(card) == "table" and card.area and card.area ~= G.jokers then
            local _bool = false
            if G.GAME.current_round.hands_played % 2 == 0 then
                _bool = true
            end

            if card.ability.thanos_pool == true then
                card:set_debuff(_bool)
                return _bool
            else
                card:set_debuff(not _bool)
                return not _bool
            end
        end
    end
}

-- When you play or discard, discard that many cards from top of deck
SMODS.Blind{
    key = "immortan_joe",
    dollars = 8,
    mult = 2,
    boss_colour = HEX('3f5634'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10, showdown = true},
    pos = { x = 0, y = 27},
    debuff = {
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    press_play = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            attention_text({
                text = localize('k_kino_blind_immortan_1'),
                scale = 1.3, 
                hold = 1.4,
                major = G.play,
                align = 'tm',
                offset = {x = 0, y = -1},
                silent = true
            })
            play_sound('tarot2', 1, 0.4)
            for i = 1, #G.play.cards do
                draw_card(G.deck,G.discard, 1*100/3,'down', false, v)
            end
        return true end }))


    end,
    calculate = function(self, blind, context)
        if context.pre_discard then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_kino_blind_immortan_1'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = G.play,
                    align = 'tm',
                    offset = {x = 0, y = -1},
                    silent = true
                })
                play_sound('tarot2', 1, 0.4)
                blind:wiggle()
                for i = 1, #context.full_hand do
                    draw_card(G.deck,G.discard, 1*100/3,'down', false, v)
                end
            return true end }))
        end
    end
}

SMODS.Blind{
    key = "palpatine",
    dollars = 8,
    mult = 2,
    boss_colour = HEX('3f5634'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10, showdown = true},
    pos = { x = 0, y = 31},
    debuff = {
        palp_damage = 0.2,
        triggers = 5
    },
    loc_vars = function(self)
        
    end,
    collection_loc_vars = function(self)

    end,
    set_blind = function(self)
        G.GAME.current_round.boss_blind_indicator = 'kinoblind_palp'
        if not G.jokers and not G.jokers.cards then return end

        for _, _joker in ipairs(G.jokers.cards) do
            local _startingvalue = 1
            _joker.ability.vader_triggers = 1
            if _joker.ability.output_powerchange and _joker.ability.output_powerchange.kinoblind_palpatine then
                _startingvalue = _joker.ability.output_powerchange.kinoblind_palpatine
            end
            Kino.setpowerchange(_joker, "kinoblind_palpatine", _startingvalue - self.debuff.palp_damage)
        end
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)
        G.GAME.current_round.boss_blind_indicator = false
    end,
    defeat = function(self)
        G.GAME.current_round.boss_blind_indicator = false
        for _, _joker in ipairs(G.jokers.cards) do
            Kino.setpowerchange(_joker, "kinoblind_palpatine", 1)
            G.jokers.cards[1].ability.vader_triggers = nil
        end
    end,
    press_play = function(self)
        
    end,
    calculate = function(self, blind, context)

        if context.after then
            for _, _joker in ipairs(G.jokers.cards) do
                _joker.ability.vader_triggers = _joker.ability.vader_triggers and _joker.ability.vader_triggers +1 or 1

                if _joker.ability.vader_triggers > 5 then
                    _joker.getting_sliced = true
                    
                    G.E_MANAGER:add_event(Event({func = function()
                        blind:wiggle()
                        card_eval_status_text(_joker, 'extra', nil, nil, nil,
                        { message = localize('k_blind_vader_1'), colour = G.C.BLACK})
                        _joker.getting_sliced = true
                        _joker:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                end
                local _startingvalue = 1
                if _joker.ability.output_powerchange and _joker.ability.output_powerchange.kinoblind_vader then
                    _startingvalue = _joker.ability.output_powerchange.kinoblind_vader
                end
                Kino.setpowerchange(_joker, "kinoblind_palpatine", _startingvalue - self.debuff.palp_damage)
            end
        end
    end
}

SMODS.Blind{
    key = "dr_evil",
    dollars = 8,
    mult = 2,
    boss_colour = HEX('dcdcdc'),
    atlas = 'kino_blinds', 
    boss = {min = 4, max = 10, showdown= true},
    pos = { x = 0, y = 29},
    debuff = {
        h_size_le = G.GAME and G.GAME.current_round.boss_blind_blofeld_counter or 100000
    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    set_blind = function(self)
        G.GAME.current_round.boss_blind_blofeld_counter = 0
    end,
    defeat = function(self)
        G.GAME.current_round.boss_blind_blofeld_counter = 10000
    end,
    disable = function(self)
        G.GAME.current_round.boss_blind_blofeld_counter = 10000
    end,
    calculate = function(self, blind, context)
        if context.after then
            G.GAME.current_round.boss_blind_blofeld_counter = #context.full_hand
        end
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if (G.GAME.current_round.boss_blind_blofeld_counter or 100000) >= #cards then
            return true
        end

        return false

        
    end
}


SMODS.Blind{
    key = "godzilla",
    dollars = 8,
    mult = 10,
    boss_colour = HEX('6fd0f7'),
    atlas = 'kino_blinds_2', 
    boss = {min = 4, max = 10, showdown = true},
    pos = { x = 0, y = 18},
    debuff = {
        lower_by = 4
    },
    loc_vars = function(self)
        return {
            vars = {
                self.debuff.lower_by
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                self.debuff.lower_by
            }
        }
    end,
    set_blind = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_barrage", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
    drawn_to_hand = function(self)
        
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
    press_play = function(self)
    end,
    calculate = function(self, blind, context)
        if context.discard then
            Kino.lower_blind(blind.debuff.lower_by)
        end
    end
}