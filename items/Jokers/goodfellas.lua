SMODS.Joker {
    key = "goodfellas",
    order = 152,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 1,
            a_money = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 1},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 769,
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
    pools, k_genre = {"Crime"},

    loc_vars = function(self, info_queue, card)

        local _my_pos = 1
        if G.jokers then
            for i = 1, #G.jokers.cards do 
                if G.jokers.cards[i] == card then 
                    _my_pos = i
                    break
                end
            end
        end

        return {
            vars = {
                card.ability.extra.a_xmult,
                card.ability.extra.a_money,
                card.ability.extra.a_xmult *_my_pos,
                -3 + card.ability.extra.a_money *_my_pos
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives xmult depending on its placement, and loses money on its placement. each joker to the right increases cost by $3 and xmult by 1
        -- If triggered while at $0, destroy card
        if context.joker_main then
            local _my_pos = nil
            for i = 1, #G.jokers.cards do 
                if G.jokers.cards[i] == card then 
                    _my_pos = i
                    break
                end
            end

            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_goodfellas_pay'),  colour = G.C.MONEY })
            local money_lost = (-1 * card.ability.extra.a_money) + card.ability.extra.a_money *_my_pos
            ease_dollars(-money_lost)

            return {
                x_mult = card.ability.extra.a_xmult *_my_pos
            }
        end

        if context.after then
            if G.GAME.dollars <= to_big(0) and not next(find_joker("j_credit_card")) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_goodfellas_leave'),
                    colour = G.C.CHIPS
                }
            end
        end
    end
}