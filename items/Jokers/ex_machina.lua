SMODS.Joker {
    key = "ex_machina",
    order = 84,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 264660,
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
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you destroy a sci-fi card, gain x0.1 for each time it was upgraded.
        if context.remove_playing_cards and not context.blueprint then
            local sci_fi_upgrades = 0
            for i, k in ipairs(context.removed) do
                if k.config.center == G.P_CENTERS.m_kino_sci_fi then
                    sci_fi_upgrades = sci_fi_upgrades + k.ability.times_upgraded
                end
            end
            if sci_fi_upgrades > 0 then
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult * (sci_fi_upgrades)
            end
        end
        
        if context.cards_destroyed and not context.blueprint then
            local sci_fi_upgrades = 0
            for i, k in ipairs(context.glass_shattered) do
                if k.config.center == G.P_CENTERS.m_kino_sci_fi then
                    sci_fi_upgrades = sci_fi_upgrades + k.ability.times_upgraded
                end
            end
            if sci_fi_upgrades > 0 then
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult * (sci_fi_upgrades)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.MULT })
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
            }
        end
    end
}