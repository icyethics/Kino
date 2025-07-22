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
            timer_num_non = 120
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
    pools, k_genre = {"Sports", "Animation"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_quick", vars = {kino_config.speed_factor}}
        return {
            vars = {
                card.ability.extra.start_chips,
                card.ability.extra.cur_chips,
                card.ability.extra.time_spent
            },
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

        if context.joker_main then
            return {
                chips = card.ability.extra.cur_chips
            }
        end

        if context.end_of_round and not context.repetition and not context.blueprint then
            card.ability.extra.cur_chips = card.ability.extra.start_chips
            card.ability.extra.time_spent = 0
        end
    end,
    add_to_deck =  function(self, card, from_debuff)
        -- card.children.timer_display = Kino.create_timer_ui(card)
        -- card.children.timer_display_2 = Kino.create_timer_ui_2(card)
    end,
    update = function(self, card, dt)
        if G.STATE ~= G.STATES.HAND_PLAYED and
        not G.SETTINGS.paused and G.GAME.blind and G.GAME.blind.in_blind then
            card.ability.extra.time_spent = card.ability.extra.time_spent + dt
            card.ability.extra.cur_chips = math.max(card.ability.extra.start_chips - math.floor(card.ability.extra.start_chips * (card.ability.extra.time_spent / card.ability.extra.timing_quick_non)), 0)
            card.ability.extra.timer_num_non = card.ability.extra.cur_chips
        end

        -- if card.area and card.area == G.jokers then
        --     card.children.timer_display = Kino.create_timer_ui(card)
        --     card.children.timer_display_2 = Kino.create_timer_ui_2(card)
        -- end
    end
}