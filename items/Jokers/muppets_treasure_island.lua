SMODS.Joker {
    key = "muppets_treasure_island",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            value = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 4, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10874,
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
    pools, k_genre = {"Comedy", "Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.value
            }
        }
    end,
    calculate = function(self, card, context)
        -- A random joker gains $2 sell value when you reroll
        if context.reroll_shop then
            local _target = pseudorandom_element(G.jokers.cards, pseudoseed("kino_muptreas"))
            _target.ability.extra_value = _target.ability.extra_value + card.ability.extra.value
            _target:juice_up()
            _target:set_cost()

            return {
                message = localize("k_kino_muppets_treasure_island")
            }
        end
    end
}