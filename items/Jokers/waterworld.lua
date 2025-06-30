SMODS.Joker {
    key = "waterworld",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9804,
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
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == "unscored" then
            local _target = pseudorandom_element(G.jokers.cards, pseudoseed("kino_waterworld"))
            _target.ability.extra_value = _target.ability.extra_value + card.ability.extra.money
            _target:set_cost()
            
            return {
                message = localize("k_kino_waterworld"),
                colour = G.C.MONEY,
                card = _target
            }
        end
    end
}