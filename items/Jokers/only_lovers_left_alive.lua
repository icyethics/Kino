SMODS.Joker {
    key = "only_lovers_left_alive",
    order = 145,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.2,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    kino_joker = {
        id = 152603,
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
    k_genre = {"Romance", "Fantasy"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult,
            }
        }
    end,
    calculate = function(self, card, context)
        -- if a pair is played, and both are romance cards, destroy them and upgrade this card with
        -- x0.2
        if context.destroying_card and context.scoring_name == "Pair" and not context.blueprint then
            local _is_rom = false
            for i = 1, #context.scoring_hand do
                if not SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_romance') and not context.scoring_hand[i].debuff then
                    break
                end
                _is_rom = true
            end
            
            -- upgrade and destroy
            if _is_rom then
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.MULT })
                return true
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
            }
        end
    end
}