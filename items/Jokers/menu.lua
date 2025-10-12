SMODS.Joker {
    key = "menu",
    order = 198,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 5, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 593643,
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
    k_genre = {"Horror", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' and not context.selling_self then
            if G.consumeables.config.card_limit - #G.consumeables.cards then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local _card = create_card('confection', G.consumeables, nil, nil, nil, nil, nil, 'menu')
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        card:juice_up(0.3, 0.5)
                    end
                    return true end }))

                return {
                    message = localize("k_menu"),
                    card = card,
                    colour = G.C.BLACK
                }
            end
        end
    end
}