SMODS.Joker {
    key = "2001_odyssey",
    order = 46,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 4,
    atlas = "kino_atlas_legendary",
    pos = { x = 0, y = 0},
    soul_pos = { x = 0, y = 1},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = false,
    kino_joker = {
        id = 62,
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
    k_genre = {"Sci-fi"},
    legendary_conditions = function(self, card)
        -- Conditions for this legendary
        -- 1: Possess a movie that shares a director
        -- 2: Possess two movies that shares a genre
        -- 3: Possess a movie that shares a release decade
        -- 4: Possess 10 or more Sci-fi cards
        -- 5: Have used 20 or more planets
        -- 6: Hold a moon tarot, and a jupiter and earth planet card in your inventory

        local _quest_status = {
            false, -- director
            false, -- genre
            false, -- release decade
            false, -- sci-fi cards
            false, -- planets used > 20
            false -- inventory
        }
        if not G.GAME or 
        not G.GAME.probabilities
        or not G.jokers then
            return _quest_status
        end

        -- Checking other joker matching qualities
        local _this_card = SMODS.Centers["j_kino_2001_odyssey"]
        local _my_release = "6"
        local _genre_match = 0
        for _, _joker in ipairs(G.jokers.cards) do
            if _joker.config.center.kino_joker then
                local _info = _joker.config.center.kino_joker

                for _, _mydir in ipairs(_this_card.kino_joker.directors) do
                    for _, _compdir in ipairs(_info.directors) do
                        if _mydir == _compdir then
                            _quest_status[1] = true
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

        -- Checking sci-fi cards in deck
        local _sci_count = 0
        for _, _item in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(_item, "m_kino_sci_fi") then
                _sci_count = _sci_count + 1
            end
        end

        if _sci_count >= 10 then
            _quest_status[4] = true
        end

        if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet >= 20 then
            _quest_status[5] = true
        end

        local _inventory_check = {false, false, false}
        for _, _consum in ipairs(G.consumeables.cards) do
            if _consum.ability.name == "Earth" then
                _inventory_check[1] = true
            end
            if _consum.ability.name == "Jupiter" then
                _inventory_check[2] = true
            end
            if _consum.ability.name == "The Moon" then
                _inventory_check[3] = true
            end
        end

        if _inventory_check[1] == true and
        _inventory_check[2] == true and
        _inventory_check[3] == true then
            _quest_status[6] = true
        end

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
                alt_text = localize("k_odyssey_quest_" .. i),
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
            },
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_odyssey'), colour = G.C.MONEY})
            for _, _card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(_card, "m_kino_sci_fi") then
                    _card.config.center:upgrade(_card)
                end
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    check_for_unlock = function(self, args)
    end,
}