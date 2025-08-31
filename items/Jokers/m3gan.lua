SMODS.Joker {
    key = "m3gan",
    order = 86,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            lower_by = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 536554,
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
    pools, k_genre = {"Sci-fi", "Horror"},
    enhancement_gate = "m_kino_sci_fi",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_sci_fi
        return {
            vars = {
                card.ability.extra.lower_by
            }
        }
    end,
    calculate = function(self, card, context)
        -- On your final hand, lower the blind with 5% for each sci-fi card in hand.
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_left == 0 then
            for k, v in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(v, "m_kino_sci_fi") then
                    v:juice_up(0.8, 0.8)
                    card_eval_status_text(v, 'extra', nil, nil, nil,
                    { message = localize('k_m3gan'), colour = G.C.BLACK })
                    G.GAME.blind.chips = G.GAME.blind.chips * ((100 - card.ability.extra.lower_by) / 100)
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                end
            end 
        end
    end
}