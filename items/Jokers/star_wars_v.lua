SMODS.Joker {
    key = "star_wars_v",
    order = 324,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            stacked_mult = 10,
            lower_mult_non = 1,
            a_mult = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1891,
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
                card.ability.extra.stacked_mult,
                card.ability.extra.lower_mult_non,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Give X2 mult. Lower it by X0.1 whenever you play a hand. Gain X0.5 when you use a Planet
        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end

        if context.after and not context.blueprint then
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult - card.ability.extra.lower_mult_non
        end

        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
        end
    end
}