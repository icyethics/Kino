if kino_config.confection_mechanic then
SMODS.Seal{
    key = "cheese",
    atlas = "kino_enhancements",
    pos = {x = 0, y = 4},
    badge_colour = HEX('d9c43c'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    calculate = function(self, card, context)
        if context.after and context.cardarea == G.play then
            if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("confection", G.pack_cards, nil, nil, true, true, nil, "kino_chef")
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(card, 
                'extra', nil, nil, nil, {message = localize('k_chef'), colour = G.C.CHIPS})                
            end
        end
    end,
}
end

SMODS.Seal{
    key = "sports",
    atlas = "kino_enhancements",
    pos = {x = 1, y = 4},
    badge_colour = HEX('eaeaea'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    calculate = function(self, card, context)
        if context.after and context.full_hand and #context.full_hand == 1 and context.cardarea == G.play then
            for _, _pcard in ipairs(G.hand.cards) do
                if card:get_id() > G.hand.cards[_]:get_id() then
                    local _card = G.hand.cards[_]
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            _card:flip()
                            _card:juice_up()
                            SMODS.modify_rank(_card, 1)
                            _card:flip()
                            card_eval_status_text(_card, 
                            'extra', nil, nil, nil, {message = localize("k_kino_sportsseal_1"), colour = G.C.CHIPS})                
                            
                            return true
                        end}))
                
                    card_eval_status_text(card, 
                            'extra', nil, nil, nil, {message = localize("k_kino_sportsseal_2"), colour = G.C.CHIPS})                
                end
            end
        end
    end,
}


SMODS.Seal{
    key = "family",
    atlas = "kino_enhancements",
    pos = {x = 2, y = 4},
    badge_colour = HEX('f2a75c'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local _suitcount = 0
            for suitname, suitdetails in pairs(SMODS.Suits) do
                for _, _pcard in ipairs(context.scoring_hand) do
                    if _pcard:is_suit(suitname) then
                        _suitcount = _suitcount + 1
                    end
                end
            end

            for _, _pcard in ipairs(context.scoring_hand) do
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus or 0
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus + (_suitcount * 3)
            end
        end
    end,
}

SMODS.Seal{
    key = "adventure",
    atlas = "kino_enhancements",
    pos = {x = 3, y = 4},
    badge_colour = HEX('aa743f'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },
    config = {
        stacks = 0,
        a_stacks = 1
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.seal.stacks
            }
        }
    end,

    calculate = function(self, card, context)
        if context.after and context.cardarea == G.play then
            card.ability.seal.stacks = card.ability.seal.stacks + (card.ability.seal.a_stacks * #context.scoring_hand)
            return {
                message = localize("k_kino_adventureseal_1") 
            }
        end

        if context.remove_playing_cards then
            for _, _card in ipairs(context.removed) do
                if _card == card then
                    ease_dollars(card.ability.seal.stacks)
                    return {
                        message = localize("k_kino_adventureseal_2") 
                    }
                end
            end
        end
    end,
}

SMODS.Seal{
    key = "thriller",
    atlas = "kino_enhancements",
    pos = {x = 4, y = 4},
    badge_colour = HEX('3d4e6a'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },
    config = {
        chance = 3
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.seal.chance, "kino_jumpscare")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,

    calculate = function(self, card, context)
        -- if context.individual and context.other_card == card then
        if context.main_scoring and context.cardarea == G.hand then
            print("test")
            -- if pseudorandom("kino_thrillerseal") < G.GAME.probabilities.normal / card.ability.seal.chance then
            if SMODS.pseudorandom_probability(card, 'kino_thrillerseal', 1, card.ability.seal.chance, "kino_jumpscare") then
                local x_mult = Kino.jumpscare(card)
                return {
                    x_mult = x_mult, 
                    message = localize('k_jump_scare'),
                    colour = HEX("372a2d"),
                    card = context.other_card
                }
            end
        end
    end,
}

SMODS.Seal{
    key = "comedy",
    atlas = "kino_enhancements",
    pos = {x = 5, y = 4},
    badge_colour = HEX('56d5b4'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    calculate = function(self, card, context)
        if context.discard and context.other_card == card and
        context.full_hand and #context.full_hand > 0 then
            if G.jokers and #G.jokers.cards > 0 then
                local _target = pseudorandom_element(G.jokers.cards, pseudoseed("kino_comedyseal"))
                -- Kino.change_counters(_target, "kino_retrigger", 1)
                _target:bb_counter_apply("counter_retrigger", 1)
            end
        end
    end,
}