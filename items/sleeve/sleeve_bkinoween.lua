if CardSleeves then
    CardSleeves.Sleeve {
        key = "kinoween_pumpkin",
        atlas = "kino_sleeves",
        pos = { x = 0, y = 3},
        config = {
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_kinoween_pumpkin" then
                key = self.key .. "_alt"
            else
                key = self.key
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.modifiers.kinoween_pumpkin_sleeve = true
        end,
        calculate = function(self, card, context)
            
            if context.setting_blind and not context.repetition and not context.blueprint and
            self.get_current_deck_key() ~= "b_kino_kinoween_pumpkin" then
                for i = 1, (G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local card = create_card('confection', G.consumeables, nil, nil, nil, nil, "c_kino_candycorn", 'kinoween_pumpkin')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            card:juice_up(0.3, 0.5)
                        end
                        return true end }))
                end
                delay(0.6)
            end
        end,
        -- Unlock Functions
        unlocked = false,
        unlock_condition = { deck = "b_kino_kinoween_pumpkin", stake = "stake_black" },
    }

    CardSleeves.Sleeve {
        key = "kinoween_vampire",
        atlas = "kino_sleeves",
        pos = { x = 1, y = 3},
        config = {
            blood_counters = 10,
            vampire_rarity = 2
        },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_kino_kinoween_vampire" then
                key = self.key .. "_alt"
                self.config = {
                    blood_counters = 10,
                    vampire_rarity = 4
                }
            else
                key = self.key
                self.config = {
                    blood_counters = 10,
                    vampire_rarity = 2
                }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            G.GAME.modifiers.kino_vampiredeck = true
            G.GAME.modifiers.kino_vampiredeck_rarity = self.config.vampire_rarity

        end,
        calculate = function(self, card, context)
            -- When you play a single enhanced card, Drain it and give a random joker +20% power
            if context.before
            and context.full_hand
            and #context.full_hand == 1
            and not context.blueprint and not context.repetition and
            self.get_current_deck_key() ~= "b_kino_kinoween_vampire" then
                local _target = context.full_hand[1]
                if Kino.drain_property(_target, card, {Enhancement = {true}}) then
                    local _valid_targets = {}
                    for _index, _joker in ipairs(G.jokers.cards) do
                        if Blockbuster.is_value_manip_compatible(_joker) then
                            _valid_targets[#_valid_targets + 1] = _joker
                        end
                    end

                    if #_valid_targets > 0 then
                        local _target = pseudorandom_element(_valid_targets, pseudoseed("kinoween_vampire_deck"))
                        Blockbuster.manipulate_value(_target, "kinoween_vampire_deck", 0.2, nil, true)
                    end
                end
            end

            if context.setting_blind and self.get_current_deck_key() == "b_kino_kinoween_vampire" then
                for i = 1, self.config.blood_counters do
                    local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_vampire_sleeve"))
                    _target:bb_counter_apply("counter_kino_blood", 1)
                end
            end
        end,
        -- Unlock Functions
        unlocked = false,
        unlock_condition = { deck = "b_kino_kinoween_pumpkin", stake = "stake_black" },
    }
end