SMODS.Joker {
    key = "dick_tracy",
    order = 273,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult_non = 0,
            factor = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8592,
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
    k_genre = {"Crime", "Action"},
    enhancement_gate = "m_kino_crime",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_non,
                card.ability.extra.factor,
                G.GAME.money_stolen
            }
        }
    end,
    calculate = function(self, card, context)
        -- when a crime card is destroyed, gain mult equal to the amount of money stolen
        if context.remove_playing_cards then
            local _count = 0
            for i = 1, #context.removed do
                if SMODS.has_enhancement(context.removed[i], 'm_kino_crime') then
                    card.ability.extra.mult_non = card.ability.extra.mult_non + (G.GAME.money_stolen * card.ability.extra.factor)
                end
            end
            return {
                message = localize('k_upgrade_ex'), 
                colour = G.C.Mult
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult_non
            }
        end
    end
}