SMODS.Joker {
    key = "citizen_kane",
    order = 46,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_xmult = 1,
            a_xmult = 0.01,
            base_value = 0.01
        }
    },
    rarity = 4,
    atlas = "kino_atlas_legendary",
    pos = { x = 2, y = 0},
    soul_pos = { x = 2, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
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
    pools, k_genre = {"Mystery", "Drama"},
    legendary_conditions = function(self, card)
        -- Conditions for this legendary

        -- 2 Movies that shares a genre
        -- a movie that shares release decade
        -- a movie that shares a cast member
        -- Have 10 different enhancements in your deck
        -- Have more than $50
        -- Have a The Emperor, The Hermit and The Earth
        

        local _quest_status = {
            false, -- genre
            false, -- release decade
            false, -- actor
            false, -- Have used 10 confections
            false, -- 10 2's 
            false -- have an Pluto, Popcorn and Pizza
        }
        if not G.GAME or 
        not G.GAME.probabilities
        or not G.jokers then
            return _quest_status
        end

        -- Checking other joker matching qualities
        local _this_card = SMODS.Centers["j_kino_citizen_kane"]
        local _my_release = "4"
        local _genre_match = 0
        for _, _joker in ipairs(G.jokers.cards) do
            if _joker.config.center.kino_joker then
                local _info = _joker.config.center.kino_joker

                for _, _myact in ipairs(_this_card.kino_joker.cast) do
                    for _, _compact in ipairs(_info.cast) do
                        if _myact == _compact then
                            _quest_status[3] = true
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
                    _quest_status[2] = true
                end
            end
        end

        if _genre_match >= 2 then
            _quest_status[1] = true
        end

        -- Checking cards in deck
        local _enhancement_count = 0
        local _threshold = 10
        local _enhancement_hash = {}
        _enhancement_hash["c_base"] = true

        for _, _pcard in ipairs(G.playing_cards) do
            local _key = _pcard.config.center.key
            if not _enhancement_hash[_key] then
                _enhancement_count = _enhancement_count + 1
            end
        end

        if _enhancement_count >= _threshold then
            _quest_status[3] = true
        end

        -- Checking confection use Conditions
        if to_big(G.GAME.dollars) >= to_big(50) then
            _quest_status[5] = true
        end

        -- Checking items in inventory

        local _inventory_check = {false, false, false}
        for _, _consum in ipairs(G.consumeables.cards) do
            if _consum == G.P_CENTERS.c_emperor then
                _inventory_check[1] = true
            end
            if _consum == G.P_CENTERS.c_hermit then
                _inventory_check[2] = true
            end
            if _consum == G.P_CENTERS.c_earth then
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
        if card.area and card.area.config.collection then
            local _quest_results, _quest_count = self:legendary_conditions(self, card)
            local _legend_quests = {}

            for i = 1, #_quest_results do
                _legend_quests[i] = {
                trigger = nil,
                type = nil,
                condition = nil,
                alt_text = localize("k_citizen_kane_quest_" .. i),
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
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_xmult,
                
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.pre_discard and context.cardarea == G.jokers) or 
        (context.before and context.cardarea == G.jokers) then
            card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
            card.ability.extra.a_xmult = card.ability.extra.a_xmult * 2
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end

        if context.end_of_round and not context.repetition and not context.blueprint then
            card.ability.extra.a_xmult = card.ability.extra.base_value
        end
    end
}