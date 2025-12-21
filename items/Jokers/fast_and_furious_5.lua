SMODS.Joker {
    key = "fast_and_furious_5",
    order = 259,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            ticking = true,
            timing_quick_non = kino_config.speed_factor,
            time_spent = 0,
            money_stolen = 20
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 4, y = 2},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 51497,
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
    k_genre = {"Crime", "Action"},
    enhancement_gate = "m_kino_crime",


    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_quick", vars = {kino_config.speed_factor}}
        return {
            vars = {
                card.ability.extra.money_stolen,
                card.ability.extra.money_stolen * (1 - (card.ability.extra.time_spent / kino_config.speed_factor))
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.repetition and not context.blueprint then
            -- stop counter
            card.ability.extra.ticking = false    
        end

        if context.start and not context.repetition and not context.blueprint then
            -- stop counter
            card.ability.extra.ticking = true    
        end

        if context.end_of_round and context.cardarea == G.jokers then
            local _percentage = 1 - (card.ability.extra.time_spent / kino_config.speed_factor)
            if _percentage < 0 then _percentage = 0 end

            Kino:increase_money_stolen((card.ability.extra.money_stolen * _percentage))

            card.ability.extra.time_spent = 0

            return {
                message = localize('k_kino_fast_and_furious_5')
            }
        end
        
    end,
    update = function(self, card, dt)
        if not G.SETTINGS.paused and G.GAME.blind and G.GAME.blind.in_blind then
            card.ability.extra.time_spent = card.ability.extra.time_spent + dt
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
        if args.type == 'round_win' and G.GAME.blind:get_type() == "Boss" and  G.GAME.round_resets.blind_choices.Boss == "bl_kino_deckard_shaw" then
            unlock_card(self)
        end
    end,
}