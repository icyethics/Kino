SMODS.Back {
    name = "Bacon Deck",
    key = "bacon",
    atlas = "kino_backs",
    pos = {x = 0, y = 1},
    config = {
    },
    apply = function()
        G.GAME.modifiers.bacon_bonus = 1.5
    end
}

SMODS.Back {
    name = "Egg Deck",
    key = "northernlion",
    atlas = "kino_backs",
    pos = {x = 1, y = 1},
    config = {
        egg_genre = "Romance"
    },
    apply = function()
        G.GAME.modifiers.egg_genre = "Romance"
    end
}

-- Jokers that spawn in the shop always share actors with your current jokers, if possible
SMODS.Back {
    name = "Cine2Nerdle Deck",
    key = "c2n",
    atlas = "kino_backs",
    pos = {x = 2, y = 1},
    config = {
    },
    apply = function()
        G.GAME.modifiers.kino_back_c2n = true
    end
}

SMODS.Back {
    name = "Producer Deck",
    key = "producer",
    atlas = "kino_backs",
    pos = {x = 3, y = 1},
    config = {
        dollars = 6,
        extra_hand_bonus = 0,
        extra_discard_bonus = 0,
        no_interest = true
    },
    apply = function()
        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
        G.GAME.modifiers.no_blind_reward.Big = true
        G.GAME.modifiers.no_blind_reward.Boss = true
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss
        and not context.individual and not context.repetition and not context.blueprint then
            local _percentage = 0
            local _kino_jokercount = 0

            for _, _joker in ipairs(G.jokers.cards) do
                
                if _joker.config.center.kino_joker then
                    _kino_jokercount = _kino_jokercount + 1
                    local _movie_info = _joker.config.center.kino_joker 

                    local budget = _movie_info.budget
                    local boxoffice = _movie_info.box_office

                    if budget == 0 then budget = 1 end
                    if boxoffice == 0 then boxoffice = 1.1 end

                    _percentage = _percentage + (boxoffice / budget)
                    if _percentage > 10 then
                        _percentage = 10
                    end

                    SMODS.calculate_effect({
                        message = "%" .. (_percentage * 100),
                        colour = G.C.MONEY
                    },
                    _joker)
                end
            end

            if _kino_jokercount > 0 then
                local reward = 10 * _percentage

                ease_dollars(reward - 10)
            end
        end
    end
}

-- SMODS.Back {
--     name = "Blank Deck with Griffin & David",
--     key = "blankcheck",
--     atlas = "kino_backs",
--     pos = {x = 4, y = 1},
--     config = {
--     },
--     apply = function()
--     end,
--     calculate = function(self, card, context)
--         if context.buying_card and context.card.config.center.kino_joker then
--             -- iterate through every joker
--             local _directors = context.card.config.center.kino_joker.directors
--             local _hash = {}
--             -- G.P_CENTER_POOLS.Joker
--             for _, _director in ipairs(_directors) do
--                 for _, _joker in ipairs(G.P_CENTER_POOLS.Joker) do
--                     if _joker.config.center.kino_joker then
--                         for _, _compdir in ipairs(_joker.config.center.kino_joker.directors) do
--                             if _director == _compdir and not _hash[_joker.config.center.key] then
--                                 _hash[_joker.config.center.key] = true
--                             end
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- }

if not Cryptid then
if kino_config.confection_mechanic then
SMODS.Back {
    name = "Snack Deck",
    key = "snackdeck",
    atlas = "kino_backs",
    pos = {x = 0, y = 2},
    config = {
        vouchers = {
            "v_kino_special_treats",
            "v_kino_snackbag",
        }
    },
    apply = function()
    end
}
end
SMODS.Back {
    name = "Trophy Deck",
    key = "trophydeck",
    atlas = "kino_backs",
    pos = {x = 1, y = 2},
    config = {
        vouchers = {
            "v_kino_awardsbait",
            "v_kino_awardsshow",
        }
    },
    apply = function()
    end
}
else
if kino_config.confection_mechanic then
SMODS.Back {
    name = "Snack Deck",
    key = "snackdeck_cryptid",
    atlas = "kino_backs",
    pos = {x = 0, y = 2},
    config = {
        vouchers = {
            "v_kino_special_treats",
            "v_kino_snackbag",
            "v_kino_heavenly_treats"
        }
    },
    apply = function()
    end
}
end

SMODS.Back {
    name = "Trophy Deck",
    key = "trophydeck_cryptid",
    atlas = "kino_backs",
    pos = {x = 1, y = 2},
    config = {
        vouchers = {
            "v_kino_awardsbait",
            "v_kino_awardsshow",
            "v_kino_egot"
        }
    },
    apply = function()
    end
}
end