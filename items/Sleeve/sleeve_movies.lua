if CardSleeves then
    -- Bacon
    CardSleeves.Sleeve {
        key = "bacon",
        atlas = "kino_sleeves",
        pos = { x = 0, y = 1 },
        config = {
            bacon_bonus = 1.5
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_bacon" then
                key = self.key .. "_alt"
                self.config = { bacon_bonus = 2 }
                vars = { (self.config.bacon_bonus - 1) * 100 }
            else
                key = self.key
                self.config = { bacon_bonus = 1.5 }
                vars = { (self.config.bacon_bonus - 1) * 100 }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.modifiers.bacon_bonus = self.config.bacon_bonus
        end
    }

    -- Cine2Nerdle
    CardSleeves.Sleeve {
        key = "c2n",
        atlas = "kino_sleeves",
        pos = { x = 2, y = 1 },
        config = {
        },
        apply = function()
            G.GAME.modifiers.kino_back_c2n = true
        end
    }

    -- Producer 
    CardSleeves.Sleeve {
        key = "producer",
        atlas = "kino_sleeves",
        pos = { x = 3, y = 1 },
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
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_producer" then
                key = self.key .. "_alt"
                vars = {}
            else
                key = self.key
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        calculate = function(self, card, context)
            if context.end_of_round
            and not context.individual and not context.repetition and not context.blueprint then
                if self.get_current_deck_key() == "b_kino_producer" or
                G.GAME.blind.boss then
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
        end
    }

    -- Investment
    CardSleeves.Sleeve {
        key = "investment",
        atlas = "kino_sleeves",
        pos = { x = 2, y = 2},
        config = {
            dollars = 6,
            extra_hand_bonus = 0,
            extra_discard_bonus = 0,
            no_interest = true
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_investment" then
                key = self.key .. "_alt"
                vars = {}
            else
                key = self.key
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        apply = function()
            G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
            G.GAME.modifiers.no_blind_reward.Small = true
            G.GAME.modifiers.no_blind_reward.Big = true
            G.GAME.modifiers.no_blind_reward.Boss = true
        end,
        calculate = function(self, card, context)
            if context.end_of_round
            and not context.individual and not context.repetition and not context.blueprint then
                if self.get_current_deck_key() == "b_kino_investment" then
                    for _index, _pcard in ipairs(G.playing_cards) do
                        -- Kino.change_counters(_pcard, "kino_investment", 1)
                        _pcard:bb_counter_apply('counter_money', 1)
                    end
                else
                    local _playbonus = 10

                    for i = 1, _playbonus do
                        local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_invdeck"))
                        -- Kino.change_counters(_target, "kino_investment", 1)
                        _target:bb_counter_apply('counter_money', 1)
                    end
                end
            end
        end
    }
    

    -- Spellslinger
    CardSleeves.Sleeve {
        key = "spellslinger",
        atlas = "kino_sleeves",
        pos = { x = 3, y = 2},
        config = {
            
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_spellslinger" then
                key = self.key .. "_alt"
                vars = {}
            else
                key = self.key
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.starting_params.kino_spellcasting_deck = true
            if self.get_current_deck_key() == "b_kino_spellslinger" then
                G.GAME.starting_params.kino_spellcasting_sleeve = true
            end
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and
            context.scoring_hand[#context.scoring_hand] == context.other_card then
                if #G.hand.cards > 2 then
                    local _result = pick_spell_reverse(context.other_card, G.hand.cards)
                    card_eval_status_text(context.other_card, 'extra', nil, nil, nil,
                    { message = localize('k_spell_cast'), colour = G.C.PURPLE })
                    return _result
                end
            end
        end
    }

    -- Dark Knight
    CardSleeves.Sleeve {
        key = "darkknight",
        atlas = "kino_sleeves",
        pos = { x = 4, y = 2},
        config = {
            
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_darkknight" then
                key = self.key .. "_alt"
                vars = {}
            else
                key = self.key
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.modifiers.kino_batmandeck = true
            G.GAME.modifiers.kino_batmandeck_rarity = G.GAME.modifiers.kino_batmandeck_rarity and 4 or 2
        end
    }

    -- Alderaan
    CardSleeves.Sleeve {
        key = "alderaan",
        atlas = "kino_sleeves",
        pos = { x = 2, y = 0},
        config = {
            
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_alderaan" then
                key = self.key .. "_alt"
                vars = {}
            else
                key = self.key
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.modifiers.kino_starwarsdeck = true
            G.GAME.modifiers.kino_starwardsdeck_rarity = G.GAME.modifiers.kino_starwardsdeck_rarity and 4 or 2
        end,
        calculate = function(self, card, context)
        -- When a round ends, level up a random hand for each remaining discard
        if context.end_of_round
        and not context.individual and not context.repetition and not context.blueprint then
            local _count = G.GAME.current_round.discards_left + G.GAME.current_round.hands_left
            
            for i = 1, _count do
                local _hand = get_random_hand()
                SMODS.smart_level_up_hand(nil, _hand, nil, 1)
            end
        end
    end
    }

    -- Cosmonaut
    -- CardSleeves.Sleeve {
    --     key = "cosmonaut",
    --     atlas = "kino_sleeves",
    --     pos = { x = 1, y = 0},
    --     config = {
            
    --     },
    --     apply = function(self, sleeve)
            
    --     end
    -- }

    CardSleeves.Sleeve {
        key = "empowered",
        atlas = "kino_sleeves",
        pos = { x = 3, y = 0},
        config = {
            
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_empowered" then
                key = self.key .. "_alt"
                vars = {}
            else
                key = self.key
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.starting_params.kino_empowereddeck = true
            if self.get_current_deck_key() == "b_kino_empowered" then
                G.GAME.starting_params.kino_empoweredsleeve = true
            end
        end
    }
    
    
    if not Cryptid then
        if kino_config.confection_mechanic then
            CardSleeves.Sleeve {
                key = "snackdeck",
                atlas = "kino_sleeves",
                pos = {x = 0, y = 2},
                config = {
                    vouchers = {
                        "v_kino_special_treats",
                        "v_kino_snackbag",
                    }
                }
            }
        end
        CardSleeves.Sleeve {
            key = "trophydeck",
            atlas = "kino_sleeves",
            pos = {x = 1, y = 2},
            config = {
                vouchers = {
                    "v_kino_awardsbait",
                    "v_kino_awardsshow",
                }
            }
        }
    else
        if kino_config.confection_mechanic then
            CardSleeves.Sleeve {
                key = "snackdeck_cryptid",
                atlas = "kino_sleeves",
                pos = {x = 0, y = 2},
                config = {
                    vouchers = {
                        "v_kino_special_treats",
                        "v_kino_snackbag",
                        "v_kino_heavenly_treats"
                    }
                }
            }
        end

        CardSleeves.Sleeve {
            key = "trophydeck_cryptid",
            atlas = "kino_sleeves",
            pos = {x = 1, y = 2},
            config = {
                vouchers = {
                    "v_kino_awardsbait",
                    "v_kino_awardsshow",
                    "v_kino_egot"
                }
            }
        }
    end

    CardSleeves.Sleeve {
        key = "deckthatmakesyouold",
        atlas = "kino_sleeves",
        pos = { x = 0, y = 0},
        config = {
            og_deck = false
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_deckthatmakesyouold" then
                key = self.key .. "_alt"
                self.config.og_deck = true
                vars = {}
            else
                key = self.key
                self.config.og_deck = false
                vars = {}
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                for _index, _pcard in ipairs(G.hand.cards) do
                    local _suits = SMODS.Suits
                    for _suitname, _suitdata in pairs(_suits) do
                        if (_pcard:is_suit(_suitname) and context.other_card:is_suit(_suitname)) or
                        self.config.og_deck then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                                _pcard:juice_up(0.8, 0.5)
                                SMODS.modify_rank(_pcard, 1)
                            return true end }))
                            break
                        end
                    end
                end
            end
        end
    }

    CardSleeves.Sleeve {
        key = "northernlion",
        atlas = "kino_sleeves",
        pos = { x = 1, y = 1 },
        config = {
            egg_genre = "Romance"
        },
        
        apply = function(self, sleeve)
            G.GAME.modifiers.egg_genre = "Romance"
        end
    }

end