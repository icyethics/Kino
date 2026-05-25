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
            blood_counters = 5,
            factor = 3
        },
        loc_vars = function(self)
            local key, vars

            if self.get_current_deck_key() == "b_kino_kinoween_vampire" then
                key = self.key .. "_alt"
                self.config = {
                    blood_counters = 10,
                    factor = 3
                }
            else
                key = self.key
                self.config = {
                    blood_counters = 5,
                    factor = 3
                }
            end
            vars = {
                self.config.factor,
                self.config.blood_counters
            }

            return { key = key, vars = vars }
        end,
        calculate = function(self, card, context)
            if context.setting_blind then
                for i = 1, card.effect.center.config.blood_counters do
                    local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_vampire_sleeve"))
                    _target:bb_counter_apply("counter_kino_blood", 1)
                end
            end
            if context.modify_weights then
                for _, _object in ipairs(context.pool) do
                    local _center = G.P_CENTERS[_object.key]
                    if _center and _center.config.is_vampire then
                        _object.weight = _object.weight * card.effect.center.config.factor
                    end
                end
            end
        end,
        -- Unlock Functions
        unlocked = false,
        unlock_condition = { deck = "b_kino_kinoween_pumpkin", stake = "stake_black" },
    }
end