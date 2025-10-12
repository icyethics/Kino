SMODS.Joker {
    key = "fish_called_wanda",
    order = 271,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 0, y = 3},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 623,
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
    k_genre = {"Crime", "Comedy"},
    enhancement_gate = 'm_kino_crime',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                G.GAME.money_stolen or 0,
                card.ability.extra.mult * G.GAME.money_stolen or 0
            }
        }
    end,
    calculate = function(self, card, context)
        -- +1 mult for each dollar stolen
        if context.joker_main then
            local _returnmult = card.ability.extra.mult * G.GAME.money_stolen
            return {
                mult = _returnmult
            }
        end
    end
}