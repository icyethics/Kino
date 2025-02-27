SMODS.Joker {
    key = "ringu",
    order = 148,
    config = {
        extra = {
            x_mult = 4.9,
            a_xmult = 0.7,
            days_left = 7
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    can_be_sold = false,
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
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
            if card.ability.extra.x_mult < 0 then
                card.ability.extra.x_mult = 0
            end

            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_ringu_countdown'),  colour = G.C.BLACK })
            card.ability.extra.days_left = card.ability.extra.days_left - 1

            if card.ability.extra.days_left < 0 and not context.blueprint and not context.repetition then


                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_ringu_death'), colour = G.C.BLACK })
                return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
                    G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
                return true end }))
            end
        end
    end
}