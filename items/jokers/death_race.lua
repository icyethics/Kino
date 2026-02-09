SMODS.Joker {
    key = "death_race",
    order = 282,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            ticking = true,
            timing_quick_non = kino_config.speed_factor,
            time_spent = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10483,
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
    k_genre = {"Action", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.max(kino_config.speed_factor - card.ability.extra.time_spent, 0)
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

        if context.end_of_round and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
            if card.ability.extra.timing_quick_non > card.ability.extra.time_spent then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("Tarot",G.consumeables, nil, nil, nil, nil, "c_death", "_race")
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
            end
            card.ability.extra.time_spent = 0
        end
    end,
    update = function(self, card, dt)
        if card.ability.extra.ticking and not G.SETTINGS.paused and G.GAME.blind and  G.GAME.blind.in_blind then
            card.ability.extra.time_spent = card.ability.extra.time_spent + dt
        end
    end
}