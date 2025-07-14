SMODS.Joker {
    key = "solo",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            planets_created = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 348350,
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
    pools = {["kino_starwars"] = true}, 
    k_genre = {"Sci-fi", "Adventure", "Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.planets_created
            }
        }
    end,
    calculate = function(self, card, context)
        -- if you play a High Card, create a random planet
        -- that isn't Pluto
        if context.joker_main and context.cardarea == G.jokers and
        context.scoring_name == "High Card" then
            for i = 1, card.ability.extra.planets_created do
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("Planet",G.consumeables, nil, nil, nil, nil, nil, "solo")
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_et')})
            end
        end
    end
}