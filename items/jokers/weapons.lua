SMODS.Joker {
    key = "weapons",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            counters_left_non = 3,
            counters_reset = 3,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1078605,
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
    k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.counters_left_non, 
                card.ability.extra.counters_reset
            }
        }
    end,
    calculate = function(self, card, context)
        -- The first 3 times each ante a 5 or lower is destroyed
        -- Create a Hanged Man
        if context.remove_playing_cards then
            local cards_created = 0
            for i = 1, #context.removed do
                
                if context.removed[i]:get_id() <= 5 and card.ability.extra.counters_left_non > 0 then
                    cards_created = cards_created + 1
                    card.ability.extra.counters_left_non = card.ability.extra.counters_left_non - 1
                end
            end

            if cards_created > 0 then
                for i = 1, cards_created do
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = create_card("Tarot",G.consumeables, nil, nil, nil, nil, "c_hanged_man", "weapons")
                            card:add_to_deck()
                            G.consumeables:emplace(card) 
                            return true
                        end}))
                end
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_kino_weapons')})
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.counters_left_non = card.ability.extra.counters_reset
        end
    end
}