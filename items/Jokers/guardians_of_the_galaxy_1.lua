SMODS.Joker {
    key = "guardians_of_the_galaxy_1",
    order = 169,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 5,
            special_a_mult = 8
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 118340,
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
                card.ability.extra.a_mult
                
            }
        }
    end,
    calculate = function(self, card, context)
        -- +5 mult for every planet in your possession (hidden effect, +8 if it's ego)
        if context.joker_main then
            local _mult = 0
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == "Planet" then
                    if G.consumeables.cards[i].key == "c_kino_ego" then
                        _mult = _mult + card.ability.extra.special_a_mult
                    else 
                        _mult = _mult + card.ability.extra.a_mult
                    end
                end
            end

            return {
                mult = _mult
            }
        end
    end
}