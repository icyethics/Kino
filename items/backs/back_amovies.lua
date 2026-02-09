SMODS.Back {
    name = "Video Store Deck",
    key = "videostore",
    atlas = "kino_backs",
    pos = {x = 2, y = 3},
    config = {
    },
    apply = function()
        G.GAME.modifiers.kino_videostore = true
        G.GAME.modifiers.kino_videostore_rarity = 2
    end
}

SMODS.Back {
    name = "Bacon Deck",
    key = "bacon",
    atlas = "kino_backs",
    pos = {x = 0, y = 1},
    config = {
    },
    apply = function()
        G.GAME.modifiers.bacon_bonus = 1.5
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _condition_failed = false
            for i, _joker in ipairs(G.jokers.cards) do
                local _has_matches = false
                local _castlist = create_cast_list_for_specific_jokers(_joker)
                for j, _jokercomp in ipairs(G.jokers.cards) do
                    if _jokercomp ~= _joker and
                    has_cast_from_table(_jokercomp, _castlist) then
                        _has_matches = true
                        break
                    end
                end

                if _has_matches == false then
                    _condition_failed = true
                    break
                end
            end
            if not _condition_failed then
                unlock_card(self)
            end
        end
    end,
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
    end,
    
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_deck' then
            if get_deck_win_stake("b_kino_bacon") > 0 then
                unlock_card(self)
            end
        end
    end,
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
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            if to_big(G.GAME.dollars) >= to_big(1000)then
                unlock_card(self)
            end
        end
    end,
}

SMODS.Back {
    name = "Investment Deck",
    key = "investment",
    atlas = "kino_backs",
    pos = {x = 2, y = 2},
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
        if context.end_of_round
        and not context.individual and not context.repetition and not context.blueprint then
            local _playbonus = 10

            for i = 1, _playbonus do
                local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_invdeck"))
                -- Kino.change_counters(_target, "kino_investment", 1)
                _target:bb_counter_apply('counter_money', 1)
            end
        end
    end,
        -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_deck' then
            if get_deck_win_stake("b_kino_producer") > 0 then
                unlock_card(self)
            end
        end
    end,

}

SMODS.Back {
    name = "Spellslinger's Deck",
    key = "spellslinger",
    atlas = "kino_backs",
    pos = {x = 3, y = 2},
    config = {
    },
    apply = function()
        G.GAME.starting_params.blockbuster_spellcasting_deck = true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        context.scoring_hand[1] == context.other_card then
            if #G.hand.cards > 2 then
                local _result = Blockbuster.cast_spell_using_recipe(context.other_card, G.hand.cards)
                return _result
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_spells_cast or 0
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'bb_spell_cast' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_spells_cast and G.PROFILES[G.SETTINGS.profile].career_stats.kino_spells_cast >= 100 then
                unlock_card(self)
            end
        end
    end,
}

SMODS.Back {
    name = "Dark Knight Deck",
    key = "darkknight",
    atlas = "kino_backs",
    pos = {x = 4, y = 2},
    config = {
    },
    apply = function()
        G.GAME.modifiers.kino_batmandeck = true
        G.GAME.modifiers.kino_batmandeck_rarity = 2
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _joker in pairs(G.P_CENTERS) do
                if kino_quality_check(_joker, 'is_batman') then
                    _total_count = _total_count + 1
                    if _joker.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
}

SMODS.Back {
    name = "Alderaan Deck",
    key = "alderaan",
    atlas = "kino_backs",
    pos = {x = 2, y = 0},
    config = {
    },
    apply = function()
        G.GAME.modifiers.kino_starwarsdeck = true
        G.GAME.modifiers.kino_starwarsdeck_rarity = 2
    end,
    calculate = function(self, card, context)
        -- When a round ends, level up a random hand for each remaining discard
        if context.end_of_round
        and not context.individual and not context.repetition and not context.blueprint then
            for i = 1, G.GAME.current_round.discards_left do
                local _hand = get_random_hand()
                SMODS.smart_level_up_hand(nil, _hand, nil, 1)
            end
            -- local _card = SMODS.create_card({
            --     area = G.consumeables, 
            --     key = "c_kino_death_star", 
            --     edition = {negative = true}
            -- })
            -- G.consumeables:emplace(_card)
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _joker in pairs(G.P_CENTERS) do
                if kino_quality_check(_joker, 'is_starwars') then
                    _total_count = _total_count + 1
                    if _joker.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
}

SMODS.Back {
    name = "Cosmonaut's Deck",
    key = "cosmonaut",
    atlas = "kino_backs",
    pos = {x = 1, y = 0},
    config = {
    },
    apply = function()

        G.GAME.modifiers.kino_cosmonaut = true
        G.GAME.modifiers.kino_cosmonaut_rarity = 4
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _planet in pairs(G.P_CENTERS) do
                if _planet.set == "Planet" and _planet.strange_planet then
                    _total_count = _total_count + 1
                    if _planet.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
}

SMODS.Back {
    name = "Empowered Deck",
    key = "empowered",
    atlas = "kino_backs",
    pos = {x = 3, y = 0},
    config = {
    },
    apply = function()
        G.GAME.starting_params.kino_empowereddeck = true
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_spells_cast or 0
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _tarot in pairs(G.P_CENTERS) do
                if _tarot.set == "Tarot" and _tarot and _tarot.original_mod  and _tarot.original_mod.id == "kino" and _tarot.config.mod_conv then
                    _total_count = _total_count + 1
                    if _tarot.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
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

if not Kino_Cryptidcheck then
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
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _confection in pairs(G.P_CENTERS) do
                if _confection.set == "confection" then
                    _total_count = _total_count + 1
                    if _confection.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
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
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_awards_given or 0,
                20
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_awards_given' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_awards_given >= 20 then
                unlock_card(self)
            end
        end
    end,
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
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _confection in pairs(G.P_CENTERS) do
                if _confection.set == "confection" then
                    _total_count = _total_count + 1
                    if _confection.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
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
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_awards_given' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_awards_given >= 5 then
                unlock_card(self)
            end
        end
    end,
}
end

SMODS.Back {
    name = "Deck That Makes You Old",
    key = "deckthatmakesyouold",
    atlas = "kino_backs",
    pos = {x = 0, y = 0},
    config = {
    },
    apply = function()
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            for _index, _pcard in ipairs(G.hand.cards) do
                local _suits = SMODS.Suits
                for _suitname, _suitdata in pairs(_suits) do
                    if _pcard:is_suit(_suitname) and context.other_card:is_suit(_suitname) then
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                            _pcard:juice_up(0.8, 0.5)
                            SMODS.modify_rank(_pcard, 1)
                        return true end }))
                        break
                    end
                end
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _condition_failed = false
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard:get_id() <= 5 then
                    _condition_failed = true
                    break
                end
            end
            if not _condition_failed then
                unlock_card(self)
            end
        end
    end,
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
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            for _, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center == G.P_CENTERS.j_egg then
                    if _joker.sell_cost >= 30 then
                        unlock_card(self)
                    end
                end
            end
        end
    end,
}

-- SMODS.Back {
--     name = "DEBUG DECK",
--     key = "debug_deck",
--     atlas = "kino_backs",
--     pos = {x = 1, y = 1},
--     config = {
--         vouchers = {
--         }
--     },
--     apply = function()
--         G.GAME.kino_boss_mode.Big = true
--         G.GAME.kino_boss_mode_odds.Big = 0.5
--         G.GAME.kino_boss_mode.Small = true
--         G.GAME.kino_boss_mode_odds.Small = 1
--     end
-- }

