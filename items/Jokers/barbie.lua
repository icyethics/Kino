SMODS.Joker {
    key = "barbie",
    order = 213,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 0.5
        }
    },
    rarity = 4,
    atlas = "kino_atlas_legendary",
    pos = { x = 3, y = 0},
    soul_pos = { x = 3, y = 1},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 346698,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    pools, k_genre = {"Comedy", "Adventure"},

    legendary_conditions = function(self, card)
        -- Conditions for this legendary
        -- Movie that shares a director
        -- 2 Movies that shares a genre
        -- Movie that shares a release decade
        -- Movie that shares an actor
        -- Have at least 60 cards in your deck
        -- Bought a minus ante voucher 
        

        local _quest_status = {
            false, -- female director
            false, -- genre
            false, -- release decade
            false, -- actor
            false, -- more Queens than Jacks + Kings
            false -- have an Empress and a Venus and Lovers
        }
        if not G.GAME or 
        not G.GAME.probabilities
        or not G.jokers then
            return _quest_status
        end

        -- Checking other joker matching qualities
        local _this_card = SMODS.Centers["j_kino_barbie"]
        local _my_release = "2"
        local _genre_match = 0
        for _, _joker in ipairs(G.jokers.cards) do
            if _joker.config.center.kino_joker then
                local _info = _joker.config.center.kino_joker

                for _, _compdir in ipairs(_info.directors) do
                    if Kino.peoplemetadata[_compdir].gender == 1 then
                        _quest_status[1] = true
                    end
                end

                for _, _myact in ipairs(_this_card.kino_joker.cast) do
                    for _, _compact in ipairs(_info.cast) do
                        if _myact == _compact then
                            _quest_status[4] = true
                        end
                    end
                end

                for _, _mygenre in ipairs(_this_card.k_genre) do
                    if is_genre(_joker, _mygenre) then
                        _genre_match = _genre_match + 1
                        break
                    end
                end
            end

            
            local _release_date = Card:get_release(_joker) 

            if _release_date then
                if string.sub(tostring(_release_date[1]), 3, 3) == _my_release then
                    _quest_status[3] = true
                end
            end
        end

        if _genre_match >= 2 then
            _quest_status[2] = true
        end

        -- Checking cards in deck
        local _queen_count = 0
        local _male_count = 0

        for _, _pcard in ipairs(G.playing_cards) do
            if _pcard:get_id() == 12 then
                _queen_count = _queen_count + 1
            elseif _pcard:get_id() == 11 or _pcard:get_id() == 13 then
                _male_count = _male_count + 1
            end
        end

        if _queen_count > _male_count then
            _quest_status[5] = true
        end

        -- Checking items in inventory

        local _inventory_check = {false, false, false}
        for _, _consum in ipairs(G.consumeables.cards) do
            if _consum.ability.name == "The Lovers" then
                _inventory_check[1] = true
            end
            if _consum.ability.name == "The Empress" then
                _inventory_check[2] = true
            end
            if _consum.ability.name == "Venus" then
                _inventory_check[3] = true
            end
        end

        if _inventory_check[1] == true and
        _inventory_check[2] == true and
        _inventory_check[3] == true then
            _quest_status[6] = true
        end

        -- Finish checks, return completion
        local _quests_complete = 0
        for _, _check in ipairs(_quest_status) do
            if _check then
                _quests_complete = _quests_complete + 1
            end
        end

        return _quest_status, _quests_complete
    end,
    loc_vars = function(self, info_queue, card) 
        -- Legendary questing testing
        if card.area and card.area.config.collection then
            local _quest_results, _quest_count = self:legendary_conditions(self, card)
            local _legend_quests = {}

            for i = 1, #_quest_results do
                _legend_quests[i] = {
                trigger = nil,
                type = nil,
                condition = nil,
                alt_text = localize("k_barbie_quest_" .. i),
                times = 0,
                goal = 1, 
                completion = _quest_results[i]
                }
            end
               
            info_queue[#info_queue + 1] = {
                set = "Other", 
                key = "kino_legendary_unlock",
                vars = {
                }, 
                main_end = Kino.create_legend_ui(card, _legend_quests, _quest_count)
            }
        end


        return {
            vars = {
                card.ability.extra.a_xmult
            },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and
        context.other_card:is_face() and not context.end_of_round then
            local _queen_count = 0
            for _, _card in ipairs(context.scoring_hand) do
                if _card:get_id() == 12 then
                    _queen_count = _queen_count + 1 
                    print(_queen_count)
                end
            end

            return {
                x_mult = 1 + (_queen_count * card.ability.extra.a_xmult)
            }
        end
    end
}