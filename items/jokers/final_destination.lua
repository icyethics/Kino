SMODS.Joker {
    key = "final_destination",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_xmult = 1,
            a_xmult = 0.25
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9532,
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

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_xmult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain x0.25 whenever a card is destroyed
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
            end
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end
    
    end
}
