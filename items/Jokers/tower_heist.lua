SMODS.Joker {
    key = "tower_heist",
    order = 260,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 5, y = 2},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 59108,
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
    pools, k_genre = {"Crime", "Comedy"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    enhancement_gate = true
                    break
                end
            end
        end

        if G.GAME.money_stolen <= 0 then
            enhancement_gate = false
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips * G.GAME.money_stolen,
            }
        }
    end,
    calculate = function(self, card, context)
        -- stone cards give +3 chips for each dollar stolen

        if context.individual and context.cardarea == G.play and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                local _chips = G.GAME.money_stolen * card.ability.extra.chips
                if _chips < 0 then _chips = 0 end
                return {
                    chips = _chips
                }
            end
        end
    end
}