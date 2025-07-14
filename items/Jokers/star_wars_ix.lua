SMODS.Joker {
    key = "star_wars_ix",
    order = 329,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            factor = 1,
            stacks = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 5, y = 0},
    cost = 3,
    blueprint_compat = false,
    perishable_compat = false,
    kino_joker = {
        id = 181812,
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
                card.ability.extra.factor,
                card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain handsize equal to the number of planet's used since last round
        if context.using_consumeable and context.consumeable.ability.set == "Planet" and not context.blueprint and not context.repetition then
            card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.factor
        end

        if context.setting_blind and not context.blueprint and not context.repetition then
            local _hand_size = card.ability.extra.stacks
            G.hand:change_size(_hand_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + _hand_size
            card.ability.extra.stacks = 0
        end
    
        

    end
}