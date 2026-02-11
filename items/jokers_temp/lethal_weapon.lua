SMODS.Joker {
    key = "lethal_weapon",
    order = 5,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 20,
            mult_decrease_non = 5,
            factor = 1,
            hand_type = "Pair"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 0 },
    cost = 2,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 941,
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
    k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_type,
                card.ability.extra.stacked_mult,
                card.ability.extra.mult_decrease_non / card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end

        if context.after and context.cardarea == G.jokers then
            if not context.blueprint and not context.repetition then
                if context.poker_hands and next(context.poker_hands[card.ability.extra.hand_type]) then

                else
                    card.ability.extra.stacked_mult = card.ability.extra.stacked_mult - (card.ability.extra.mult_decrease_non / card.ability.extra.factor)
                    
                    if card.ability.extra.stacked_mult <= 0 then
                    
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_kino_perished'), colour = G.C.Mult })
                        card:start_dissolve()
                    else
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_kino_downgrade_ex'), colour = G.C.Mult })
                    end
                end
            end
        end
    end
}