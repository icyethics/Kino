SMODS.Joker {
    key = "singing_in_the_rain",
    order = 46,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 2,
            counters_applied = 1
        }
    },
    rarity = 4,
    atlas = "kino_atlas_legendary",
    pos = { x = 3, y = 2},
    soul_pos = { x = 3, y = 3},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 238,
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
    k_genre = {"Musical", "Romance"},
    legendary_conditions = function(self, card)
        -- Conditions for this legendary

        -- 2 Movies that shares a genre
        -- Have 20 enhanced cards in your deck
        -- Make 5 matches
        -- Movie that shares a release decade
        -- Movie that shares an actor
        -- Have a Lovers, Venus and Hot Dog
        

        local _quest_status = {
            false, -- genre
            false, -- release decade
            false, -- actor
            false, -- Have 20 Counters
            false, -- Have played 20 or more unscoring cards
            false -- , Emperor and Slice of Pizza
        }
        if not G.GAME or 
        not G.GAME.probabilities
        or not G.jokers then
            return _quest_status
        end

        -- Checking other joker matching qualities
        local _this_card = SMODS.Centers["j_kino_singing_in_the_rain"]
        local _my_release = "5"
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

        -- Checking straights played
        if G.GAME.kino_unscored_cards_played and G.GAME.kino_unscored_cards_played >= 20 then
            _quest_status[5] = true
        end

        -- Checking number cards in deck
        if G.playing_cards then
            if Blockbuster.Counters.get_total_counters(nil, "Full Deck").counter_values >= 20 then
                _quest_status[4] = true
            end
        end


        -- Checking items in inventory

        local _inventory_check = {false, false, false}
        for _, _consum in ipairs(G.consumeables.cards) do
            if _consum == G.P_CENTERS.c_lovers then
                _inventory_check[1] = true
            end
            if _consum == G.P_CENTERS.c_kino_popcorn then
                _inventory_check[2] = true
            end
            if _consum == G.P_CENTERS.c_mars then
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
                alt_text = localize("k_kino_singing_in_the_rain_quest_" .. i),
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
                card.ability.extra.factor,
                card.ability.extra.counters_applied
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == "unscored" then
            context.other_card.kino_singing_in_the_rain = true
        end
        if context.after and context.cardarea == G.jokers then
            for i, _pcard in ipairs(context.full_hand) do
                if _pcard.kino_singing_in_the_rain then
                    local _valid_counter_types = Blockbuster.Counters.get_counter_pool({"beneficial"}, true)
                    local _target = pseudorandom_element(_valid_counter_types, pseudoseed('kino_singing_in_the_rain'))
                    _pcard:bb_counter_apply(_target, card.ability.extra.counters_applied)
                    card_eval_status_text(_pcard, 'extra', nil, nil, nil,
                    { message = localize('k_kino_singing_in_the_rain'), colour = G.C.FILTER})
                    _pcard.kino_singing_in_the_rain = nil
                end
            end            
        end

        if context.bb_counter_applied then
            return {
                bb_counter_number = context.number * card.ability.extra.factor,
            }
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