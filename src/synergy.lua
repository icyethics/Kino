
function Card:kino_synergy(card)
    -- Iterate through all other jokers and check the following:
    -- If they share a genre
    -- If they share a director
    -- If they share an actor

    -- If they have the Bacon sticker

    -- If 5 share an actor, x2 all values
    -- if 3 share an actor, start shaking (and display the actor)

    if not kino_config.actor_synergy  or not self.config.center.kino_joker then
        return 0
    end

    local _my_pos = nil

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
            _my_pos = i
        end
    end

    local _left = _my_pos - 1
    local _right = _my_pos + 1

    local _actors = self.config.center.kino_joker.cast
    card.ability.current_synergy_actors = {
        -- actor_ID = num of matches
    }



    -- Iterate through actor list
    for _, actor in pairs(_actors) do
        local _joker_hash = {}
        -- Iterate through other jokers
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card and 
            (kino_config.self_synergize or 
            G.jokers.cards[i].config.center ~= self.config.center and not _joker_hash[G.jokers.cards[i].config.center.key]) then
                if G.jokers.cards[i].config.center.kino_joker then
                    local _compared_actors = G.jokers.cards[i].config.center.kino_joker.cast

                    -- now iterate through the checked jokers and see if there's a match
                    for _j, comp_actor in pairs(_compared_actors) do
                        if actor == comp_actor then

                            if not card.ability.current_synergy_actors[actor] then
                                card.ability.current_synergy_actors[actor] = 1
                            end
                            card.ability.current_synergy_actors[actor] = card.ability.current_synergy_actors[actor] + 1
                        end
                    end
                end

                _joker_hash[G.jokers.cards[i].config.center.key] = true
            end
        end
    end

    local _count = 0
    for actor_id, frequency in pairs(card.ability.current_synergy_actors) do
        local _num = ((frequency + G.GAME.current_round.actors_table_offset) <= #Kino.actor_synergy) and frequency + G.GAME.current_round.actors_table_offset or #Kino.actor_synergy
        local _order = Kino.actor_synergy[_num]
        if frequency < G.GAME.current_round.actors_check then
            Blockbuster.manipulate_value(card, actor_id, _order)
        end
        if frequency >= G.GAME.current_round.actors_check and _count <= 2 then
            _count = _count + 1
            local _multiplier = Blockbuster.manipulate_value(card, actor_id, _order)
        end
    end

    local _return_count = 0
    if _count > 0 then
        if _count > (card.ability.last_actor_count or 0) then
            _return_count = _count
        end

        card.ability.last_actor_count = _count
    end

    if self.ability.kino_bacon or G.GAME.modifiers.bacon_bonus then

        local _found_match = false
        local _found_match_right = false
        local _found_match_left = false
        
        for _i, actor in pairs(_actors) do
            -- test left
            if G.jokers.cards[_left] and G.jokers.cards[_left].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_left].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        _found_match_left = true
                    
                        break
                    end
                end
            end

            -- test right
            if G.jokers.cards[_right] and G.jokers.cards[_right].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_right].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        _found_match_right = true
                        break
                    end
                end
            end
        end

        if self.ability.kino_bacon then
            if not _found_match then
                SMODS.debuff_card(card, true, "bacon")
            else
                SMODS.debuff_card(card, false, "bacon")
            end
        end
        
        if G.GAME.modifiers.bacon_bonus then
            if not _found_match_right then
                Blockbuster.manipulate_value(card, "bacon_deck_right", 1)
            else
                Blockbuster.manipulate_value(card, "bacon_deck_right", G.GAME.modifiers.bacon_bonus)
            end

            if not _found_match_left then
                Blockbuster.manipulate_value(card, "bacon_deck_left", 1)
            else
                Blockbuster.manipulate_value(card, "bacon_deck_left", G.GAME.modifiers.bacon_bonus)
            end
        end

    end

    return _return_count
end

local _DEBUGcount = 0
function check_genre_synergy()
    -- check jokers, then if 5 of them share a genre, add a joker slot
    if not G.jokers or not G.jokers.cards or not kino_config.genre_synergy
    or not G.GAME.current_round.genre_synergy_treshold 
    or G.jokers.config.card_limit == 0 then
        return false
    end


    local five_of_genres = {}

    if not G.jokers.config.synergyslots then
        G.jokers.config.synergyslots = 0
        G.GAME.kino_current_synergyslots = 0
    end

    -- G.jokers.config.card_limit = G.jokers.config.card_limit - G.jokers.config.synergyslots
    for i, genre in ipairs(kino_genres) do
        local count = 0
        for j, joker in ipairs(G.jokers.cards) do
            if G.GAME.modifiers.kino_genre_variety then
                check_genre_match(joker)            
            end
            if G.GAME.modifiers.kino_genre_snob then
                check_genre_snob()
            end

            if is_genre(joker, genre) then
                count = count + 1
            end
        end
        
        if count >= G.GAME.current_round.genre_synergy_treshold then
            five_of_genres[#five_of_genres + 1] = genre
        end
    end
    print(#G.jokers.cards)
    if #five_of_genres > G.GAME.kino_current_synergyslots then
        -- Genre synergy!
        for i, genre in ipairs(five_of_genres) do
            local _text = localize('k_genre_synergy')
            if G.GAME.modifiers.egg_genre and genre == "Romance" then
                _text = localize('k_genre_synergy_egg')
            end

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = _text,
                    scale = 1.3, 
                    hold = 1.4,
                    major = G.play,
                    align = 'tm',
                    offset = {x = 0, y = -1},
                    silent = true
                })
                play_sound('tarot2', 1, 0.4)
            return true end }))
        end
    end

    
    G.GAME.kino_current_synergyslots = (#five_of_genres * Kino.genre_synergy_slots)

    if G.GAME.kino_current_synergyslots ~= #five_of_genres then
        if G.GAME.kino_current_synergyslots > #five_of_genres then
            local _dif = #five_of_genres - G.GAME.kino_current_synergyslots
            G.jokers.config.card_limit = G.jokers.config.card_limit + _dif
        elseif G.GAME.kino_current_synergyslots < #five_of_genres then
            local _dif = G.GAME.kino_current_synergyslots - #five_of_genres
            G.jokers.config.card_limit = G.jokers.config.card_limit - _dif
        end
    end
    
    if G.GAME.kino_current_synergyslots > 0 then
        G.jokers.config.card_limit_UI_text = " (+" .. G.GAME.kino_current_synergyslots .. " Genre Bonus)"
    else
        G.jokers.config.card_limit_UI_text = ""
    end
    -- G.jokers:draw()
end

function check_actor_synergy()

    if not kino_config.actor_synergy or not G.jokers or not G.jokers.cards then
        return false
    end

    for i = 1, #G.jokers.cards do
        local _retcount = G.jokers.cards[i]:kino_synergy(G.jokers.cards[i])
        if _retcount > 0 then
            card_eval_status_text(G.jokers.cards[i], 'extra', nil, nil, nil,
            { message = localize('k_actor_synergy'), colour = G.C.LEGENDARY})
            G.jokers.cards[i]:juice_up()
        end
    end
end

function check_genre_match(joker)
    -- Checks to see how many jokers share a genre with the joker that the function uses
    if not joker or not joker.config.center.kino_joker then
        return 
    end

    local _jokers_that_share_genre = 0
    -- iterate through each genre
    for _, _genre in ipairs(joker.config.center.k_genre) do
        for __, _joker_comp in ipairs(G.jokers.cards) do
            if _joker_comp ~= joker then
                if is_genre(_joker_comp, _genre) then
                    _jokers_that_share_genre = _jokers_that_share_genre + 1
                    break
                end
            end
        end
        if _jokers_that_share_genre > 0 and not joker.debuff then
            SMODS.debuff_card(joker, true, "kino_genre_variety_" .. _genre)
        elseif _jokers_that_share_genre == 0 and joker.debuff then
            SMODS.debuff_card(joker, false, "kino_genre_variety_" .. _genre)
        end
    end
end

function check_genre_snob()
    -- active joker ==
    if not G.jokers or not G.jokers.cards or (#G.jokers.cards < 1) then return end
    if not G.jokers.cards[1].config.center.kino_joker then return end

    local _active_genres = G.jokers.cards[1].config.center.k_genre

    for i = 1, #G.jokers.cards do
        local _genre_match = false
        local _joker = G.jokers.cards[i]
        for _, _genre in ipairs(_active_genres) do
            if is_genre(_joker, _genre) then
                _genre_match = true
                break
            end
        end

        if i > 1 and _genre_match == false and not _joker.debuff then
            SMODS.debuff_card(_joker, true, "kino_genre_snob")
        elseif i == 1 and (_genre_match == true and _joker.debuff) then
            SMODS.debuff_card(_joker, false, "kino_genre_snob")
        end
    end
end