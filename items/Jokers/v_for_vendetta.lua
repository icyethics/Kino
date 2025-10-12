SMODS.Joker {
    key = "v_for_vendetta",
    order = 343,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 0, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 752,
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
    k_genre = {"Action", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- each card gives +1 mult for each 5 scored. Resets when you play a face card
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 5 then
                card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.Mult })
            elseif context.other_card:is_face() then
                card.ability.extra.stacked_mult = 0
                return {
                    
                }
            end

            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}