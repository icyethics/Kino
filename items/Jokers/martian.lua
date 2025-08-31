SMODS.Joker {
    key = "martian",
    order = 297,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            items_created = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 2, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 286217,
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
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_kino_mars
        return {
            vars = {
                card.ability.extra.items_created
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == "Planet" and context.consumeable.ability.name == "Mars" then
                for i = 1, card.ability.extra.items_created do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local card = create_card('confection', G.consumeables, nil, nil, nil, nil, nil, 'martian')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            card:juice_up(0.3, 0.5)
                        end
                    return true end }))
                end
            end
        end
    end
}