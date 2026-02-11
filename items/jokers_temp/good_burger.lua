SMODS.Joker {
    key = "good_burger",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 3, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 14817,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When an enhanced card is draw, gain +2 chips
        if context.hand_drawn and not context.blueprint then
            local _triggered = false
            for i = 1, #context.hand_drawn do
                if context.hand_drawn[i].config.center ~= G.P_CENTERS.c_base then
                    card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
                    _triggered = true
                end
            end

            if _triggered then
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.CHIPS
                }
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
    end
}