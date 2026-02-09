SMODS.Joker {
    key = "shining",
    order = 47,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 694,
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
    k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                if context.hand_drawn[i].base.id == 11 and 
                context.hand_drawn[i].config.center ~= G.P_CENTERS.m_stone then

                    card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult

                    if pseudorandom("shining") < (1/10) then
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_shining'), colour = G.C.MULT })
                    else
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize({type='variable', key = 'a_mult', vars = {card.ability.extra.stacked_mult}}), colour = G.C.MULT })
                    end
                    
                end
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult,
                card = card
            }
        end

        if context.after and not context.blueprint and not context.repetition then
            card.ability.extra.stacked_mult = 0
        end
    end
}