SMODS.Joker {
    key = "gone_girl",
    order = 36,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 210577,
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
    k_genre = {"Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
    -- Queens give X1
    -- Any jacks or Kings played in the same hand are debuffed and increase the mult by x0.25

    -- Jack/King check
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.id == 11 or context.other_card.base.id == 13 then
                if not context.other_card.debuff then
                    local _card = context.other_card
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                        _card:juice_up()
                        card_eval_status_text(_card, 'extra', nil, nil, nil,
                        { message = localize('k_gone_girl_male'), colour = G.C.BLACK })
                        SMODS.debuff_card(_card, true, card.config.center.key)
                    return true end }))

                    card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
                end
            end
        end

        if context.individual and context.cardarea == G.play then 
            if context.other_card and context.other_card.base.id == 12 then
                card_eval_status_text(context.other_card, 'extra', nil, nil, nil,
                { message = localize('k_gone_girl_female'), colour = G.C.RED })
                return {
                    x_mult = card.ability.extra.stacked_x_mult
                }
            end
        end
    end
}