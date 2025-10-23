SMODS.Enhancement {
    key = "horror",
    atlas = "kino_enhancements",
    pos = { x = 2, y = 0},
    config = {
        extra = {
            x_chips_return = 2,
            chips = 60,
            cur_chance = 1,
            a_chance = 1,
            chance = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        if not card.fake_card then
            info_queue[#info_queue+1] = G.P_CENTERS.m_kino_monster
        end

        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.cur_chance, card.ability.extra.chance, "kino_monster_transform")
        return {
            vars = {
                card.ability.extra.chips,
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- Reworked effect: +50 chips when scored. 
        -- 1/5 chance to wake up for each turn in hand

        -- Reset chance when drawn
        if context.hand_drawn then
            for i, _pcard in ipairs(context.hand_drawn) do
                if _pcard == card then
                    card.ability.extra.cur_chance = 1
                end
            end
        end

        -- Change into monster card
        if context.main_scoring and context.cardarea == G.hand then
            if SMODS.pseudorandom_probability(card, 'kino_horror_enhancement', card.ability.extra.cur_chance, card.ability.extra.chance, "kino_monster_transform") then
                G.GAME.current_round.horror_transform = G.GAME.current_round.horror_transform + 1
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_monster_turn'), colour = G.C.BLACK })
                card:set_ability(G.P_CENTERS.m_kino_monster, nil, true)
                SMODS.calculate_context({monster_awaken = true})

                if next(find_joker("j_kino_wolf_man_1")) then
                    return {
                        x_mult = 2
                    }
                end
            else
                card.ability.extra.cur_chance = math.min(card.ability.extra.cur_chance + 1, card.ability.extra.chance)
            end
        end

        -- Score when played
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end

    end
}

SMODS.Enhancement {
    key = "monster",
    atlas = "kino_enhancements",
    pos = { x = 2, y = 1},
    config = {

    },
    hidden = true,
    replace_base_card = true,
    overrides_base_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 0,
    loc_vars = function(self, info_queue, card)
        if not card.fake_card then
            info_queue[#info_queue+1] = G.P_CENTERS.m_kino_horror
        end
    end,
    calculate = function(self, card, context, effect)
        if context.after and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.4)
                    card:set_ability(G.P_CENTERS.m_kino_horror, nil, true)
                    return true
                end,
            }))
            
        end
    end
}