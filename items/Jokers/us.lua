SMODS.Joker {
    key = "us",
    order = 43,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 458723,
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
    pools, k_genre = {"Horror"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_horror") or
                SMODS.has_enhancement(v, "m_kino_monster") then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a Horror card wakes up, gain x0.1
        if context.monster_awaken and not context.blueprint then
            card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.MULT })
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
            }
        end

    end
}