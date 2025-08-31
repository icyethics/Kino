SMODS.Joker {
    key = "i_robot",
    order = 82,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1.00,
            a_xmult = 0.05
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 2048,
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
    pools, k_genre = {"Sci-fi"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_sci_fi
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- If a sci-fi card upgrades, gain x0.05
        if context.upgrading_sci_fi_card and not context.blueprint then
            card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.MULT })
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult,
                message = localize{type='variable', key = 'a_xmult', vars = {card.ability.extra.stacked_x_mult}},
            }
        end
    end
}