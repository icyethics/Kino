SMODS.Joker {
    key = "fast_and_furious_5",
    order = 259,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            ticking = true,
            timing_quick_non = kino_config.speed_factor,
            time_spent = 0,
            money_stolen = 10,
            timer_num_non = kino_config.speed_factor
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

    has_timer = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_quick", vars = {kino_config.speed_factor}}
        local _percentage = card.ability.extra.time_spent / card.ability.extra.timing_quick_non
        return {
            vars = {
                card.ability.extra.money_stolen,
                math.ceil(math.max(card.ability.extra.money_stolen * (1 - _percentage),0)),
                G.GAME.money_stolen,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local _timer = 1
            card.ability.extra.time_spent = 0
            card.ability.extra.timer_num_non = math.ceil(math.max(card.ability.extra.timer_num_non - card.ability.extra.time_spent, 0))

            local event
            event = Event {
                blockable = false,
                blocking = false,
                pause_force = true,
                no_delete = true,
                trigger = "after",
                delay = _timer,
                timer = "UPTIME",
                func = function()
                    card.ability.extra.time_spent = card.ability.extra.time_spent + 1
                    card.ability.extra.timer_num_non = math.ceil(math.max(card.ability.extra.timer_num_non - card.ability.extra.time_spent, 0))
                    if card.ability.extra.time_spent <= card.ability.extra.timing_quick_non and G.hand and G.GAME.blind.in_blind then
                        event.start_timer = false
                    else
                        return true
                    end
                end
            }
            

            G.E_MANAGER:add_event(event)
        end

        if context.end_of_round and context.cardarea == G.jokers then
            local _percentage = 1 - card.ability.extra.time_spent / card.ability.extra.timing_quick_non
            if _percentage < 0 then _percentage = 0 end

            Kino:increase_money_stolen(math.ceil(math.max(card.ability.extra.money_stolen * (1 - _percentage),0)))

            card.ability.extra.time_spent = 0

            return {
                message = localize('k_kino_fast_and_furious_5')
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
        if args.type == 'round_win' and G.GAME.blind:get_type() == "Boss" and  G.GAME.round_resets.blind_choices.Boss == "bl_kino_deckard_shaw" then
            unlock_card(self)
        end
    end,
}