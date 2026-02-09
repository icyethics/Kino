
SMODS.Tag {
    key = 'trickortreat_1',
    atlas = 'kino_tags',
    pos = {
        x = 1,
        y = 3
    },
    min_ante = 1,
    config = {
        type = 'immediate'
    },
    loc_vars = function(self, info_queue)
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            if pseudorandom("kino_treat_trick") > 0.5 then
                for i = 1, 2 do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('timpani')
                        local card = create_card('confection', G.consumeables, nil, nil, nil, nil, nil, 'founder')
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        
                        G.consumeables:emplace(card)
                        card:juice_up(0.3, 0.5)
                    return true end }))
                end
            else
                local _low_impact = pseudorandom("kino_treat_trick")
                local _message_type = 3
                if _low_impact < 0.33 then
                    ease_dollars(-G.GAME.dollars / 4)
                    _message_type = 1
                elseif _low_impact < 0.66 then
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, 2 do
                            local _pool = {G.P_CARDS.H_2, G.P_CARDS.C_2, G.P_CARDS.D_2, G.P_CARDS.S_2}
                            local _card = create_playing_card({
                                front = pseudorandom_element(_pool, pseudoseed('ghoulies')), 
                                center = G.P_CENTERS.m_kino_flying_monkey}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        end
                        return true
                    end}))
                    _message_type = 2
                else
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, 5 do
                            local _pool = {G.P_CARDS.H_2, G.P_CARDS.C_2, G.P_CARDS.D_2, G.P_CARDS.S_2}
                            local _card = create_playing_card({
                                front = pseudorandom_element(_pool, pseudoseed('ghoulies')), 
                                center = G.P_CENTERS.m_stone}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        end
                        return true
                    end}))
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                attention_text({
                                    text = localize('k_tag_treat_low_' .. _message_type),
                                    scale = 1.3, 
                                    hold = 1.4,
                                    major = G.play,
                                    align = 'tm',
                                    offset = {x = 0, y = -1},
                                    silent = true
                                })
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
            tag:yep('+', G.C.GREEN, function()
                G.GAME.confections_powerboost = G.GAME.confections_powerboost + 1
                return true
            end)
            tag.triggered = true
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end
}

SMODS.Tag {
    key = 'trickortreat_2',
    atlas = 'kino_tags',
    pos = {
        x = 1,
        y = 3
    },
    min_ante = 1,
    config = {
        type = 'immediate'
    },
    no_collection = true,
    loc_vars = function(self, info_queue)
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            if pseudorandom("kino_treat_trick") > 0.5 then
                for i = 1, 3 do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('timpani')
                        local card = create_card('confection', G.consumeables, nil, nil, nil, nil, nil, 'founder')
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        
                        G.consumeables:emplace(card)
                        card:juice_up(0.3, 0.5)
                    return true end }))
                end
            else
                local _mid_impact = pseudorandom("kino_treat_trick")
                local _message_type = 3
                if _mid_impact < 0.33 then
                    ease_dollars(-G.GAME.dollars / 1.5)
                    _message_type = 1
                elseif _mid_impact < 0.66 then
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, #G.playing_cards / 4 do
                            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.playing_cards, {"none"})
                            
                            if #_valid_targets > 0 then
                                local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_trick_or_treat_bad"))
                                _target:bb_counter_apply("counter_poison", 1)
                            end
                            
                        end
                        return true
                    end}))
                    _message_type = 2
                else
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, math.min(#G.playing_cards, 4) do
                            local _valid_targets = {}
                            
                            for _index, _pcard in ipairs(G.playing_cards) do
                                if _pcard:is_face() then
                                    _valid_targets[#_valid_targets + 1] = _pcard 
                                end
                            end

                            if #_valid_targets > 0 then
                                local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_trick_or_treat_bad"))
                                SMODS.destroy_cards(_target)
                            end
                            
                        end
                        return true
                    end}))
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                attention_text({
                                    text = localize('k_tag_treat_mid_' .. _message_type),
                                    scale = 1.3, 
                                    hold = 1.4,
                                    major = G.play,
                                    align = 'tm',
                                    offset = {x = 0, y = -1},
                                    silent = true
                                })
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
            tag:yep('+', G.C.GREEN, function()
                G.GAME.confections_powerboost = G.GAME.confections_powerboost + 1
                return true
            end)
            tag.triggered = true
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end
}


SMODS.Tag {
    key = 'trickortreat_3',
    atlas = 'kino_tags',
    pos = {
        x = 1,
        y = 3
    },
    min_ante = 1,
    config = {
        type = 'immediate'
    },
    no_collection = true,
    loc_vars = function(self, info_queue)
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            if pseudorandom("kino_treat_trick") > 0.5 then
                for i = 1, 5 do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('timpani')
                        local card = create_card('confection', G.consumeables, nil, nil, nil, nil, nil, 'founder')
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        
                        G.consumeables:emplace(card)
                        card:juice_up(0.3, 0.5)
                    return true end }))
                end
            else
                local _mid_impact = pseudorandom("kino_treat_trick")
                local _message_type = 3
                if _mid_impact < 0.33 then
                    ease_dollars(-G.GAME.dollars - 20)
                    _message_type = 1
                elseif _mid_impact < 0.66 then
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, 8 do
                            local _pool = {G.P_CARDS.H_2, G.P_CARDS.C_2, G.P_CARDS.D_2, G.P_CARDS.S_2}
                            local _card = create_playing_card({
                                front = pseudorandom_element(_pool, pseudoseed('ghoulies')), 
                                center = G.P_CENTERS.m_kino_monster}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        end
                        return true
                    end}))
                    _message_type = 2
                else
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _counter_types = Blockbuster.Counters.get_counter_pool("detrimental", true)
                        for i = 1, #G.playing_cards do
                            local _valid_targets = Blockbuster.Counters.get_counter_targets(G.playing_cards, {"none"})
                            
                            if #_valid_targets > 0 then
                                local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_trick_or_treat_bad"))
                                local _counter_type = pseudorandom_element(_counter_types, pseudoseed("kino_trick_or_treat_bad"))
                                _target:bb_counter_apply(_counter_type, 1)
                            end
                            
                        end
                        return true
                    end}))
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                attention_text({
                                    text = localize('k_tag_treat_bad_' .. _message_type),
                                    scale = 1.3, 
                                    hold = 1.4,
                                    major = G.play,
                                    align = 'tm',
                                    offset = {x = 0, y = -1},
                                    silent = true
                                })
                                return true
                            end
                        }))
                        return true
                    end
                }))
                
            end
            tag:yep('+', G.C.GREEN, function()
                G.GAME.confections_powerboost = G.GAME.confections_powerboost + 1
                return true
            end)
            tag.triggered = true
        end
    end,
    in_pool = function(self, args)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end
}