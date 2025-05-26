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
        for _, _pcard in ipairs(G.deck.cards) do
            if SMODS.has_enhancement(_pcard, "m_kino_wifi") then
                total_chips = total_chips + _pcard:get_chip_bonus()
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
SMODS.Enhancement {
    key = "angelic",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 2, y = 0},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)

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
                print(_totalpercentage)
                for i = 1, _total_rounds do
                    local value = pseudorandom("m_kino_finance_interest", _min, _max)
                    print(_totalpercentage .. " x " .. value)
                    _totalpercentage = _totalpercentage * value
                    print(_totalpercentage)
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

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)

    end,
}

-- Time Cards
SMODS.Enhancement {
    key = "time",
    atlas = "kino_morefluff_enhancements",
    pos = { x = 0, y = 1},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)

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

end