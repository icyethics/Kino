SMODS.current_mod.calculate = function(self, context)

    -- Synergy System
    if context.kino_joker_order_change and context.full_area then
        -- check_genre_synergy()
        Kino.actor_adjacency_check()
        Kino.genre_adjacency_check()

    end
    
    -- Stat Tracking related Calculations
    if context.individual then
        if context.cardarea == "unscored" then
            G.GAME.kino_played_unscoring_card = true

            inc_career_stat("kino_unscored_cards_played", 1)

            if context.other_card.config.center == G.P_CENTERS.m_kino_crime then
                check_for_unlock({type="kino_wanda"})
            end
        end

        if context.cardarea == G.play then
            if context.other_card:get_id() <= 5 then
                G.GAME.kino_played_5_or_lower = true
            end

            if context.other_card:is_face() == false then
                G.GAME.kino_played_non_faces_this_round = true
            end
        end
    end

    if context.joker_type_destroyed then
        if context.card.ability.set == "Joker" and is_genre(context.card, "Romance") then
            inc_career_stat("kino_romance_jokers_destroyed", 1)
        end
    end

    if context.remove_playing_cards then
        if not G.GAME.face_card_destroyed or (G.GAME.face_card_destroyed and G.GAME.face_card_destroyed <= 10) then
            for i = 1, #context.removed do
                if context.removed[i]:is_face() then
                    G.GAME.face_card_destroyed = G.GAME.face_card_destroyed or 0
                    G.GAME.face_card_destroyed = G.GAME.face_card_destroyed + 1
                end
                if context.removed[i]:get_id() <= 5 then
                    G.GAME.kino_played_5_or_lower = true
                end
                if context.removed[i].debuff == true then
                    check_for_unlock({type="kino_destroyed_debuffed_card"})
                end
                if context.removed[i].config.center == G.P_CENTERS.m_kino_sci_fi then
                    inc_career_stat("kino_sci_fi_cards_destroyed", 1)
                end

                G.GAME.kino_destroyed_ranks_hash = G.GAME.kino_destroyed_ranks_hash or {}
                G.GAME.kino_destroyed_ranks_count = G.GAME.kino_destroyed_ranks_count or 0
                if not G.GAME.kino_destroyed_ranks_hash[context.removed[i]:get_id()] then
                    G.GAME.kino_destroyed_ranks_hash[context.removed[i]:get_id()] = true
                    G.GAME.kino_destroyed_ranks_count = G.GAME.kino_destroyed_ranks_count + 1
                end

                if G.GAME.kino_destroyed_ranks_count >= 13 then
                    check_for_unlock({type="kino_destroyed_every_rank"})
                end
                
            end

            if G.GAME.face_card_destroyed and G.GAME.face_card_destroyed >= 10 then
                check_for_unlock({type="kino_ten_faces_destroyed"})
            end
        end
    end

    if context.using_consumeable then
        G.GAME.consumeables_used = G.GAME.consumeables_used or {}
        G.GAME.consumeables_used[context.consumeable.config.center.key] = G.GAME.consumeables_used[context.consumeable.config.center.key] or 0
        G.GAME.consumeables_used[context.consumeable.config.center.key] = G.GAME.consumeables_used[context.consumeable.config.center.key] + 1

        G.GAME.consumeables_used_this_run = G.GAME.consumeables_used_this_run or 0
        G.GAME.consumeables_used_this_run = G.GAME.consumeables_used_this_run + 1

        if context.consumeable.config.center.set == "confection" then
            G.GAME.confections_used.all = G.GAME.confections_used.all + 1
            G.GAME.confections_used[context.consumeable.config.center.key] = G.GAME.confections_used[context.consumeable.config.center.key] or 0
            G.GAME.confections_used[context.consumeable.config.center.key] = G.GAME.confections_used[context.consumeable.config.center.key] + 1
            inc_career_stat("kino_confections_used", 1)
        end

        if context.consumeable.config.center.strange_planet then
            G.GAME.strange_planets_used = G.GAME.strange_planets_used or 0
            G.GAME.strange_planets_used = G.GAME.strange_planets_used + 1
            inc_career_stat("kino_strange_planets_used", 1)
            check_for_unlock({type = 'kino_strange_planet'})
        end

        if context.consumeable.config.center == G.P_CENTERS.c_death then
            local rightmost = G.hand.highlighted[1]
            for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
            if rightmost.config.center == G.P_CENTERS.m_lucky then
                G.GAME.kino_lucky_death = true
            end

            if rightmost:is_face() and G.hand.highlighted[1]:get_id() == 2 then
                check_for_unlock({type="kino_shazam_unlock"})
            end

            if G.hand.highlighted[1]:get_id() == G.hand.highlighted[2]:get_id() then
                check_for_unlock({type="kino_death_on_same_card"})
            end
        end

        if context.consumeable.config.center == G.P_CENTERS.c_emperor then
            if G.GAME.blind:get_type() == 'Boss' and
            G.GAME.round_resets.blind_choices.Boss == "bl_kino_palpatine" then
                check_for_unlock({type="kino_double_emp"})
            end
        end

        if context.consumeable.config.center == G.P_CENTERS.c_hanged_man then
            for i=1, #G.hand.highlighted do 
                if G.hand.highlighted[i].config.center == G.P_CENTERS.m_lucky then 
                    G.GAME.kino_lucky_hanged_man = true
                end 
            end
        end

        if G.GAME.consumeables_used.c_devil and
        G.GAME.consumeables_used.c_kino_demon then
            check_for_unlock({type="kino_used_devil_and_demon"})
        end
        check_for_unlock({type="kino_consumable_used"})
    end

    if context.card_added then
        if kino_quality_check(context.card, "is_vampire") then
            inc_career_stat("kino_vampire_jokers_obtained", 1)
        end
    end

    if context.selling_card then
        if context.card.ability.set == "Joker" then
            if context.card.edition then
                check_for_unlock({type="kino_sold_joker_with_edition"})
            end
            if is_genre(context.card, "Romance") then
                G.GAME.kino_romance_jokers_sold = G.GAME.kino_romance_jokers_sold or 0
                G.GAME.kino_romance_jokers_sold = G.GAME.kino_romance_jokers_sold + 1
                if G.GAME.kino_romance_jokers_sold >= 5 then
                    check_for_unlock({type="kino_five_romance_sold"})
                end
            end
        end
    end

    if context.after then
        for i, _hand in ipairs(get_least_played_hand(true)) do
            if context.scoring_name == _hand then
                G.GAME.kino_played_least_played_hand_this_round = true
            end
        end

        -- Temporary Handsize
        if G.GAME.kino_temporary_handsize and G.GAME.kino_temporary_handsize > 0 then
            Kino.reset_temporary_hand_size()
        end
    end

    if context.hand_drawn then
        if G.GAME.kino_temporary_handsize_prep and G.GAME.kino_temporary_handsize_prep > 0 then
            Kino.add_temporary_hand_size()
        end
    end

    if context.setting_blind then
        G.GAME.kino_played_non_faces_this_round = false
        G.GAME.kino_played_least_played_hand_this_round = false
    end
end