SMODS.Joker {
    key = "indiana_jones_1",
    order = 92,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_xmult = 1,
            a_xmult = 0.5
        }
    },
    rarity = 4,
    atlas = "kino_atlas_legendary",
    pos = { x = 4, y = 0},
    soul_pos = { x = 4, y = 1},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 85,
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
    k_genre = {"Adventure"},
    legendary_conditions = function(self, card)
        -- Conditions for this legendary
        -- Movie that shares a director
        -- 2 Movies that shares a genre
        -- Movie that shares a release decade
        -- Movie that shares an actor
        -- Have at least 60 cards in your deck
        -- Bought a minus ante voucher 
        

        local _quest_status = {
            false, -- director
            false, -- genre
            false, -- release decade
            false, -- actor
            false, -- 60 cards
            false -- vouchers
        }
        if not G.GAME or 
        not G.GAME.probabilities
        or not G.jokers then
            return _quest_status
        end

        -- Checking other joker matching qualities
        local _this_card = SMODS.Centers["j_kino_indiana_jones_1"]
        local _my_release = "8"
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

        if #G.playing_cards >= 60 then
            _quest_status[5] = true
        end

        if G.GAME.used_vouchers.v_hieroglyph or G.GAME.used_vouchers.v_petroglyph then
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
                alt_text = localize("k_indiana_quest_" .. i),
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

        if not G.GAME.current_round.kino_indiana_key then
            G.GAME.current_round.kino_indiana_rank = 2
            G.GAME.current_round.kino_indiana_suit = "Spades"
            G.GAME.current_round.kino_indiana_key = "S_2"
        end


        return {
            vars = {
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_xmult,
                G.P_CARDS[G.GAME.current_round.kino_indiana_key].name
            },
        }
    end,
    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play and 
        context.other_card:get_id() == G.GAME.current_round.kino_indiana_rank and
        context.other_card:is_suit(G.GAME.current_round.kino_indiana_suit) then
            card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
        end

        if context.joker_main then
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_raiders'), colour = G.C.MONEY})
            return {
                x_mult = card.ability.extra.stacked_xmult
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