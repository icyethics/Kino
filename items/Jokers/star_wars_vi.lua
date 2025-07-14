SMODS.Joker {
    key = "star_wars_vi",
    order = 325,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            stacked_chips = 10,
            factor = 4,
            divide_factor_non = 0.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 1, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1892,
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
    k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.factor,
                card.ability.extra.divide_factor_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- give +1 chips. Doubles when you use a planet. Halves when you play a hand
        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end

        if context.after and card.ability.extra.stacked_chips > 1 and not context.blueprint then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips * card.ability.extra.divide_factor_non
        end

        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips * card.ability.extra.factor
        end
    end
}