SMODS.Joker {
    key = "simpsons",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_created = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 4, y = 4},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 35,
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
    k_genre = {"Comedy", "Animation"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_kino_donut
        return {
            vars = {
                card.ability.extra.cards_created
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.repetition and not context.blueprint then
            for i = 1, card.ability.extra.cards_created do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local card = create_card('confection', G.consumeables, nil, nil, nil, nil, "c_kino_donut", 'kino_simpsons')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        card:juice_up(0.3, 0.5)
                    end
                return true end }))
            end
        end
    end
}