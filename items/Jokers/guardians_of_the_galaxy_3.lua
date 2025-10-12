SMODS.Joker {
    key = "guardians_of_the_galaxy_3",
    order = 199,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 3},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 447365,
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
    k_genre = {"Sci-fi", "Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            for i, _card in ipairs(G.consumeables.cards) do
                if _card.ability.set == "Planet" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            _card:flip()
                            delay(0.1)
                            _card:set_edition({negative = true}, true)
                            _card:flip()
                            delay(0.1)
                            card_eval_status_text(_card, 'extra', nil, nil, nil,
                            { message = localize('k_guardians_3'), colour = G.C.LEGENDARY})
                            return true
                        end
                    }))
                end
            end
        end
    end
}