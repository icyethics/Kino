SMODS.Joker {
    key = "robocop_1",
    order = 13,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 5548,
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
    k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a High Card is played, turn all scoring unenhanced cards into Sci-fi cards after scoring.

        if context.individual and context.scoring_name == "High Card" and
        context.cardarea == G.play and
        context.other_card.config.center == G.P_CENTERS.c_base and not
        context.blueprint then
            
            context.other_card:set_ability(G.P_CENTERS.m_kino_sci_fi, nil, true)
            
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.MULT })
        end

    end
}