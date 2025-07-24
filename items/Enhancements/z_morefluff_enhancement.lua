if next(SMODS.find_mod("MoreFluff")) then

-- Error Cards
SMODS.Enhancement {
    key = "error",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 0, y = 0},
    config = {
        give_mult = 3,
        give_xmult = 2,
        give_chips = 25,
        give_xchips = 2,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.give_xchips
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.hand then

            local _randchance = pseudorandom("m_kino_error_effect")
            local _randchange = pseudorandom("m_kino_error_change", -0.2, 0.2)

            -- 4/8 chance to give xchips
            if _randchance < 0.5 then
                return {
                    x_chips = card.ability.give_xchips + _randchange
                }
            
            -- 2/8 chance to give xmult
            elseif _randchance < 0.75 then
                return {
                    x_mult = card.ability.give_xmult + _randchange
                }
            
            -- 1/8 chance to give flat mult
            elseif _randchance < 0.875 then
                return {
                    mult = card.ability.give_mult + _randchange
                }

            -- 1/16 chance to give flat chips
            elseif _randchance < 0.9375 then
                return {
                    chips = card.ability.give_chips + _randchange
                }

            -- 1/16 chance to not trigger
            else
                return {

                }
            end
        end
    end,
}

-- Wi-fi Cards
SMODS.Enhancement {
    key = "wifi",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 1, y = 0},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        local total_chips = 0
        if G.deck and G.deck.cards then
            for _, _pcard in ipairs(G.deck.cards) do
                if SMODS.has_enhancement(_pcard, "m_kino_wifi") then
                    total_chips = total_chips + _pcard:get_chip_bonus()
                end
            end
        end
        return {
            vars = {
                total_chips
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            local total_chips = 0
            for _, _pcard in ipairs(G.deck.cards) do
                if SMODS.has_enhancement(_pcard, "m_kino_wifi") then
                    total_chips = total_chips + _pcard:get_chip_bonus()
                end
            end

            return {
                chips = total_chips
            }
        end
    end,
}

-- Angelic Cards
-- +10 chips for each card held in hand
SMODS.Enhancement {
    key = "angelic",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 2, y = 0},
    config = {
        a_chips = 15,
        base_chance = 1,
        chance = 4
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.a_chips,
                G.GAME.probabilities.normal * card.ability.base_chance,
                card.ability.chance
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then

            local _added_cards = 0
            -- Copying
            if pseudorandom("m_kino_angelic_chance") < (G.GAME.probabilities.normal * card.ability.base_chance) / 2 then
                local _target = pseudorandom_element(G.playing_cards, pseudoseed("m_kino_angelic_target"))
                
                local _card = copy_card(_target)
                _card:set_ability("m_kino_angelic")

                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                G.hand:emplace(_card)
                _card.states.visible = nil
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                _added_cards = _added_cards + 1

                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card:start_materialize()
                        return true
                    end
                })) 

                playing_card_joker_effects({true})
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_kino_angelic_create'), colour = G.C.MONEY})
                card:juice_up()
            end


            -- Scoring
            return {
                chips = card.ability.a_chips * (#G.hand.cards + _added_cards)
            }
        end

    end,
}

-- finance Cards
SMODS.Enhancement {
    key = "finance",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 3, y = 0},
    config = {
        currently_investing = false,
        started_investing = 0,
        money_invested = 0
    },
    loc_vars = function(self, info_queue, card)
        
        return {
            vars = {
                math.max(G.GAME.round - card.ability.started_investing, 0),
                card.ability.money_invested
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.currently_investing then
                local _totalpercentage = 1
                local _min = 0.9
                local _max = 1.5

                local _total_rounds = G.GAME.round - card.ability.started_investing
                for i = 1, _total_rounds do
                    local value = pseudorandom("m_kino_finance_interest", _min, _max)
                    _totalpercentage = _totalpercentage * value
                end

                local _final_result = card.ability.money_invested * _totalpercentage
                -- ease_dollars(_final_result)

                card.ability.currently_investing = false
                card.ability.started_investing = 0
                card.ability.money_invested = 0

                return {
                    message = localize('k_kino_finance_investing_2'),
                    dollars = _final_result
                }
                
            end

            if not card.ability.currently_investing then
                card.ability.currently_investing = true
                card.ability.started_investing = G.GAME.round
                local testnum =  to_number(G.GAME.dollar_buffer and G.GAME.dollar_buffer or 0)
                card.ability.money_invested = (to_number(G.GAME.dollars) + testnum) / 2
                G.GAME.dollar_buffer = -card.ability.money_invested
                return {
                    message = localize('k_kino_morefluff_finance_investing'),
                    dollars = -card.ability.money_invested
                }
            end




        end
    end,
}

-- factory Cards
SMODS.Enhancement {
    key = "factory",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 5, y = 0},
    config = {
        factory_stored_suits = {
            -- Keeps the suits in here
            Hearts = 0,
            Diamonds = 0,
            Clubs = 0,
            Spades = 0,
            Suitless = 0,
            Overflow = 0,
        },
        threshold = 5,
        reward_per_suit = {
            Hearts = "Tarot",
            Spades = "Rotarot",
            Clubs = "Planet",
            Diamonds = "confection",
            Suitless = "Spectral"
        }
    },
    loc_vars = function(self, info_queue, card)
        -- 
        local _ui = {}

        for _suit, _value in pairs(card.ability.factory_stored_suits) do
            if _value > 0 and G.C.SUITS[_suit] then
                local _suitstring = "Overflow"
                if G.C.SUITS[_suit] then
                    _suitstring = localize(_suit, "suits_plural")
                elseif _suit == "Suitless" then
                    _suitstring = "Suitless"
                end

                local _text = _suitstring .. ": " .. _value .. ""

                _ui[#_ui + 1] = {
                    n = G.UIT.R,
                    config = {   
                        r = 0.1,
                        align = 'lm'
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = _text,
                                colour = G.C.UI.TEXT_DARK, 
                                scale = 0.25, 
                                shadow = false
                            }
                        }
                    }
                }
            end
        end

        return {
            vars = {
                card.ability.threshold
            },
            main_end = _ui 
        }
    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            -- Set values
            for i, _playedcard in ipairs(context.full_hand) do
                if _playedcard ~= card then
                    local _suits = SMODS.Suits
                    for _suitname, _suitdata in pairs(_suits) do
                        if SMODS.has_no_suit(_playedcard) then
                            card.ability.factory_stored_suits.suitless = card.ability.factory_stored_suits.suitless + 1
                        elseif _playedcard:is_suit(_suitname) then
                            if card.ability.factory_stored_suits[_suitname] then
                                card.ability.factory_stored_suits[_suitname] = card.ability.factory_stored_suits[_suitname] + 1
                            else
                                print(_suitname .. " Does Not Exist")
                                card.ability.factory_stored_suits.overflow = card.ability.factory_stored_suits.overflow + 1
                            end
                        end
                    end
                end
            end

            -- Start creating
            for _suit, _value in pairs(card.ability.factory_stored_suits) do
                if _value >= card.ability.threshold and _suit ~= "Overflow" then
                    card.ability.factory_stored_suits[_suit] = card.ability.factory_stored_suits[_suit] - card.ability.threshold

                    G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local card = create_card(card.ability.reward_per_suit[_suit],G.consumeables, nil, nil, nil, nil, nil, 'kino_fac')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        return true
                    end)}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.PURPLE})
                end
            end
        end
    end,
}

-- Time Cards
SMODS.Enhancement {
    key = "time",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 0, y = 1},
    config = {
        base_chips = 120,
        decay_rate = 10,
        current_chips = 0,
        angle = 0,
        started_decay = false,
        tick = 0
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.base_chips,
                card.ability.decay_rate,
                math.max(card.ability.current_chips, 0)
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- When drawn to hand, start counting down
        if context.hand_drawn then
            for i, _pcard in ipairs(context.hand_drawn) do
                if _pcard == card then
                    card.ability.started_decay = true
                    card.ability.current_chips = 60
                    local event
                    event = Event {
                        blockable = false,
                        blocking = false,
                        pause_force = true,
                        no_delete = true,
                        trigger = "after",
                        delay = 5/3,
                        timer = "UPTIME",
                        func = function()
                            card.ability.tick = card.ability.tick + 1
                            if card.ability.tick == 3 then
                                card.ability.tick = 0
                                card.ability.current_chips = card.ability.current_chips - card.ability.decay_rate
                            end
                            
                            card.ability.angle = card.ability.angle + 10

                            if card.ability.current_chips > 0 then
                                event.start_timer = false
                            else
                                return true
                            end
                        end
                    }

                    G.E_MANAGER:add_event(event)
                end
            end
        end

        if context.joker_main then
            return {
                chips = math.max(card.ability.current_chips, 0)
            }
        end
    end,
}

-- Fraction Cards
SMODS.Enhancement {
    key = "fraction",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 1, y = 1},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        local _left = "??"
        local _right = "??"

        if card.area then
            local _coord = 0
            for _, _scoring_card in ipairs(card.area.cards) do
                if _scoring_card == card then
                    _coord = _
                end
            end

            

            if _coord > 1 then
                _left = card.area.cards[_coord - 1]:get_chip_bonus()
            end

            _right = card:get_chip_bonus()
        end


        return {
            vars = {
                _left,
                _right
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            local _total_mult = 0
            local _coord = 0
            for _, _scoring_card in ipairs(context.full_hand) do
                if _scoring_card == card then
                    _coord = _
                end
            end

            local _left = 0

            if _coord > 1 then
                _left = context.full_hand[_coord - 1]:get_chip_bonus()
            end

            local _right = card:get_chip_bonus()

            if _left <= 0 then
                _total_mult = 0
            elseif _right <= 0 then
                _total_mult = 0
            else 
                _total_mult = _left / _right
            end
            return {
                mult = _total_mult
            }
        end
    end,
}

-- Draw steps
SMODS.DrawStep {
    key = "kino_morefluff_angelic",
    order = 30,
    func = function(card, layer)
        if card and SMODS.has_enhancement(card, 'm_kino_angelic') then
            if G.shared_enhancement_sprites and G.shared_enhancement_sprites.angelic_sprite then
                local _updown = 0.25 - ((5) * (0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3))
                G.shared_enhancement_sprites.angelic_sprite.role.draw_major = card 
                G.shared_enhancement_sprites.angelic_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, _updown, nil, 0.6)
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

SMODS.DrawStep {
    key = "kino_morefluff_time",
    order = 30,
    func = function(card, layer)
        if card and SMODS.has_enhancement(card, 'm_kino_time') then
            if G.shared_enhancement_sprites and G.shared_enhancement_sprites.time_sprite then
                card.kino_time_card_rotation = card.kino_time_card_rotation or 0
                local _currentrotation_target = (card.ability.angle / 360) * 2*math.pi
                local _difference = _currentrotation_target - card.kino_time_card_rotation
                card.kino_time_card_rotation = card.kino_time_card_rotation + (_difference * 0.02*math.sin(0.1*G.TIMERS.REAL)) 

                G.shared_enhancement_sprites.time_sprite.role.draw_major = card 
                G.shared_enhancement_sprites.time_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, _currentrotation_target, nil, nil, nil, 0.6)
                -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}
end