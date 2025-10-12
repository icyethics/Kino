SMODS.Joker {
    key = "wonka",
    order = 187,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 787699,
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
    k_genre = {"Fantasy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.confection or 0)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _mult = card.ability.extra.a_mult * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.confection or 0)

            return {
                mult = _mult
            }
        end
    end
}