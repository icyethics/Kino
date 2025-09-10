SMODS.Joker {
    key = "ringu",
    order = 148,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 4.9,
            a_xmult = 0.7,
            days_left_non = 7
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    can_be_sold = false,
    kino_joker = {
        id = 2671,
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

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.after and context.cardarea == G.jokers then
            card.ability.extra.x_mult = card.ability.extra.x_mult - card.ability.extra.a_xmult
            if card.ability.extra.x_mult < 0.05 then
                card.ability.extra.x_mult = 0
            end

            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_ringu_countdown'),  colour = G.C.BLACK })
            card.ability.extra.days_left_non = card.ability.extra.days_left_non - 1

            if card.ability.extra.days_left_non < 0 and not context.blueprint and not context.repetition then

                G.GAME.loss_condition = "ringu"

                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_ringu_death'), colour = G.C.BLACK })
                return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 4, func = function()
                    G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
                return true end }))
            end
        end
    end
}

SMODS.JimboQuip({
    key = 'ringu_1',
    type = 'loss',
    extra = {
        center = 'j_kino_ringu',
        particle_colours = {
            G.C.BLACK,
            G.C.PURPLE,
		    G.C.NEGATIVE
        }
    },
    filter = function(self, type)
        if G.GAME.loss_condition and G.GAME.loss_condition == "ringu" then
            return true, { weight = 10000 }
        end
    end
})