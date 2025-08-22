-- Abducted objects can be any card object
-- Abductions happen on trigger, and are ended when a Boss blind is defeated
-- After an abduction ends, the source of the abduction is checked
-- and an effect happens. If no specifics are given,
-- the abducted card is returned to the cardarea it came from
-- regardless of whether there is space

-- If the source of an abduction is sold or destroyed, the abducted items are sold or destroyed with them
-- local _o_gsr = Game.start_run
-- function Game:start_run(args)
--     _o_gsr(self, args)

--     -- Abduction Mechanics
--     self.kino_abductionarea = CardArea(
--         0,
--         0,
--         self.CARD_W * 4.95,
--         self.CARD_H * 0.95,
--         {
--             card_limit = 999,
--             type = "abduction",
--             highlight_limit = 0
--         }
--     )
--     self.kino_abductionarea.states.visible = false
--     Kino.abduction = G.kino_abductionarea

--     -- Confection Mechanics
--     self.kino_snackbag = CardArea(
--         G.consumeables.T.x + 2.25,
--         G.consumeables.T.y + G.consumeables.T.h + 1,
--         self.CARD_W * 2.2,
--         self.CARD_H * 0.95,
--         {
--             card_limit = 4,
--             type = 'joker',
--             highlight_limit = 1,
--             -- card_w = G.CARD_W * 0.7,
--         }
--     )
--     self.kino_snackbag.states.visible = false
--     Kino.snackbag = G.kino_snackbag

-- end

Kino.abduction_id_num_list = {}
Kino.register_abducter_entity = function(card)

    if card.ability.kino_abductor_id then
        Kino.abduction_id_num_list[card.ability.kino_abductor_id] = card
    else
        local _kino_abductor_id = #Kino.abduction_id_num_list + 1
        card.ability.kino_abductor_id = _kino_abductor_id
        Kino.abduction_id_num_list[card.ability.kino_abductor_id] = card
    end
    
end

-- Abduction functions
Kino.abduct_card = function(card, abducted_card)
    if not card or not card.area then return end
    if not abducted_card or not abducted_card.area then return end
    local _ret = SMODS.calculate_context({pre_abduct = true}, {stop_abduction = false})

    if _ret and _ret.stop_abduction then
        return
    end

    if abducted_card.shattered or abducted_card.destroyed or abducted_card.abducted then
        return
    end

    if abducted_card.ability.set ~= 'Joker' then
        abducted_card.abducted = true
        G.GAME.current_round.abduction_waitinglist[#G.GAME.current_round.abduction_waitinglist + 1] = {
            abductor = card,
            abducted_card = abducted_card,
            abducted_from = abducted_card.area
        }
    else

        abducted_card.abducted = true
        card:juice_up()
        G.GAME.current_round.cards_abducted = G.GAME.current_round.cards_abducted + 1
        if not card.ability.extra.cards_abducted then
            card.ability.extra.cards_abducted = {
                -- Cards should be formatted as such
                -- {
                --     -- card = card,
                --     -- abudcted_from = cardarea,
                --     -- abducted_when = when,
                -- }
            }
        end

        abducted_card.area.config.card_limit = abducted_card.area.config.card_limit - ((abducted_card.edition and abducted_card.edition.negative) and 1 or 0)
        card.ability.extra.cards_abducted[#card.ability.extra.cards_abducted + 1] = {
            card = abducted_card,
            abducted_from = abducted_card.area
        }
    
        abducted_card.area:remove_card(abducted_card)
        Kino.abduction:emplace(abducted_card)

    end
    SMODS.calculate_context({abduct = true, joker = card, abducted_card = abducted_card})
end

Kino.unabduct_cards = function(card)
    if not card or not card.area then return end
    if not card.ability.extra.cards_abducted or #card.ability.extra.cards_abducted == 0 then return end

    local _table = card.ability.extra.cards_abducted
    local _cardtable = Kino.gather_abducted_cards_by_abductor(card)


    -- for i, abductee in ipairs(_table) do
    for i = #_table,1,-1 do
        local abductee = _table[i]
        print(abductee)
        local _card = _cardtable[i]
        print(_cardtable[i])
        _card.area:remove_card(_card)
        _card.abducted = false

        local _cardarea = G.deck
        if _card.ability.set == 'Joker' then
            _cardarea = G.jokers
        end
        -- if abductee.abducted_from ~= G.play and
        -- abductee.abducted_from ~= G.hand then
        --     _cardarea = abductee.abducted_from 
        -- end

        _cardarea:emplace(_card)
        table.remove(_table, i)
        table.remove(_cardtable, i)
        if _cardarea ~= G.jokers and 
        _cardarea ~= G.consumeables then
            table.insert(G.playing_cards, _card)
        end
    end

    if #_table == 0 then
        _table = {}
    end

    return _table

end

Kino.abduction_end = function()
    SMODS.calculate_context({abduction_ending = true})
    
end

Kino.gather_abducted_cards_by_abductor = function(card)
    local _id = card.ability.kino_abductor_id
    if not _id then
        print("Set up incorrectly, internal ID for this joker is missing")
    end

    local _list_of_cards = {}

    for _index, _card in ipairs(Kino.abduction.cards) do
        if _card.ability.kino_abductor_id == _id then
            _list_of_cards[_card.ability.kino_abduction_id] = _card
        end
    end

    return _list_of_cards
end

G.FUNCS.draw_from_area_to_abduction = function(e)
    
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.1,
        func = function()
            local _cards_to_be_abducted = G.GAME.current_round.abduction_waitinglist

            for _, command in ipairs(_cards_to_be_abducted) do
                local _abductor = command.abductor
                local _abductee = command.abducted_card
                local _abducted_from = command.abducted_from

                if _abductor and _abductor.juice_up then
                    _abductor:juice_up()
                end
                
                G.GAME.current_round.cards_abducted = G.GAME.current_round.cards_abducted + 1

                _abductee.area.config.card_limit = _abductee.area.config.card_limit - ((_abductee.edition and _abductee.edition.negative) and 1 or 0)
                
                if not _abductor.ability.extra.cards_abducted then
                    _abductor.ability.extra.cards_abducted = {
                        -- Cards should be formatted as such
                        -- {
                        --     -- card = card,
                        --     -- abudcted_from = cardarea,
                        --     -- abducted_when = when,
                        -- }
                    }
                end

                _abductee.ability.kino_abductor_id = _abductor.ability.kino_abductor_id
                _abductee.ability.kino_abduction_id = #_abductor.ability.extra.cards_abducted + 1
                _abductor.ability.extra.cards_abducted[_abductee.ability.kino_abduction_id] = {
                    abducted_from = _abducted_from
                }

                _abductee.area:remove_card(_abductee)
                
                if G.playing_cards then
                    for k, v in ipairs(G.playing_cards) do
                        if v == _abductee then
                            table.remove(G.playing_cards, k)
                            break
                        end
                    end
                    for k, v in ipairs(G.playing_cards) do
                        v.playing_card = k
                    end
                end

                Kino.abduction:emplace(_abductee)

            end

            
            G.GAME.current_round.abduction_waitinglist = {}
            return true end
    }))
end

function Card:abduct_animation(dissolve_colours, silent, dissolve_time_fac, no_juice)
    local dissolve_time = 0.7*(dissolve_time_fac or 1)
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.BLUE, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    if not no_juice then self:juice_up() end
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
    if not silent then 
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
                    play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                    play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end