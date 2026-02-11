SMODS.Joker {
    key = "piranha_2",
    order = 15,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_wet = true,
        extra = {
            mult = 10,
            triggered = false
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 2},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 31646,
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
    k_genre = {"Horror"},
    is_wet = true,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.triggered = false
        end

        if context.individual and context.cardarea == "unscored" and card.ability.extra.triggered == false then
            card.ability.extra.triggered = true

            return {
                mult = card.ability.extra.mult
            }

        end
    end
}