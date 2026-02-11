SMODS.Joker {
    key = "cars_1",
    order = 164,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            start_chips = 120,
            cur_chips = 120,
            ticking = true,
            timing_quick_non = kino_config.speed_factor,
            time_spent = 0,
            timer_num_non = kino_config.speed_factor,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 3},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 920,
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
    k_genre = {"Sports", "Animation"},
    is_cars = true,
    has_timer = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_quick", vars = {kino_config.speed_factor}}
        local _percentage = card.ability.extra.time_spent / card.ability.extra.timing_quick_non
        return {
            vars = {
                card.ability.extra.start_chips,
                card.ability.extra.start_chips - math.ceil(math.max(card.ability.extra.start_chips * _percentage,0))
            },
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

        if context.joker_main then
            local _percentage = card.ability.extra.time_spent / card.ability.extra.timing_quick_non

            return {
                chips = card.ability.extra.start_chips - math.ceil(math.max(card.ability.extra.start_chips * _percentage,0))
            }
        end

        if context.end_of_round and not context.repetition and not context.blueprint then
            card.ability.extra.time_spent = 0
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
        if args.type == 'kino_beans_and_movies' then
            unlock_card(self)
        end
    end,
}