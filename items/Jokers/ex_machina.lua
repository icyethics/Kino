SMODS.Joker {
    key = "ex_machina",
    order = 76,
    config = {
        extra = {
            xmult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you destroy a sci-fi card, gain x0.1 for each time it was upgraded.
        if context.remove_playing_cards and not context.blueprint then
            print("Enter")
            local sci_fi_upgrades = 0
            for i, k in ipairs(context.removed) do
                if k.config.center == G.P_CENTERS.m_kino_sci_fi then
                    sci_fi_upgrades = sci_fi_upgrades + k.ability.times_upgraded
                end
            end
            if sci_fi_upgrades > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.a_xmult * (sci_fi_upgrades)
            end
        end
        
        if context.cards_destroyed and not context.blueprint then
            print("Enter")
            local sci_fi_upgrades = 0
            for i, k in ipairs(context.glass_shattered) do
                if k.config.center == G.P_CENTERS.m_kino_sci_fi then
                    sci_fi_upgrades = sci_fi_upgrades + k.ability.times_upgraded
                end
            end
            if sci_fi_upgrades > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.a_xmult * (sci_fi_upgrades)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.MULT })
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}