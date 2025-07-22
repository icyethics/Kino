SMODS.Joker {
    key = "wall_e",
    order = 85,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 1,
            a_mult_alt = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10681,
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
    pools, k_genre = {"Sci-fi", "Animation", "Family"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.a_mult_alt,
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)
        --When you discard an enhanced card, gain +1 mult. If it was a Gold, Steel, or Sci-fi card, gain +3 instead
        if context.discard and not context.other_card.debuff
        and not context.blueprint then
            if context.other_card.config.center ~= G.P_CENTERS.c_base then
                local _multgain = card.ability.extra.a_mult
                if SMODS.has_enhancement(context.other_card, "m_kino_sci_fi") or
                SMODS.has_enhancement(context.other_card, "m_steel") or
                SMODS.has_enhancement(context.other_card, "m_gold") then
                    _multgain = card.ability.extra.a_mult_alt
                end

                card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + _multgain
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.CHIPS })
            end          
        end

        if context.joker_main then
            if card.ability.extra.stacked_mult > 0 then
                return {
                    mult = card.ability.extra.stacked_mult
                }
            end
        end
    end
}