if kino_config.horror_enhancement then
    SMODS.Consumable {
        key = "slasher",
        set = "Tarot",
        order = 1,
        pos = {x = 0, y = 0},
        atlas = "kino_tarot",
        config = {
            mod_conv = 'm_kino_horror', 
            max_highlighted = 2,
        },
        get_weight_mod = function()
            if G.GAME.kino_genre_weight["Horror"] and G.GAME.kino_genre_weight["Horror"] > 0 then
                return 2
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_horror
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end
    }
end

if kino_config.sci_fi_enhancement then
    SMODS.Consumable {
        key = "droid",
        set = "Tarot",
        order = 2,
        pos = {x = 1, y = 0},
        atlas = "kino_tarot",
        config = {
            mod_conv = 'm_kino_sci_fi', 
            max_highlighted = 1,
        },
        get_weight_mod = function()
            if G.GAME.kino_genre_weight["Sci-fi"] and G.GAME.kino_genre_weight["Sci-fi"] > 0 then
                return 2
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_sci_fi
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end
    }
end

if kino_config.demonic_enhancement then
    SMODS.Consumable {
        key = "demon",
        set = "Tarot",
        order = 3,
        pos = {x = 2, y = 0},
        atlas = "kino_tarot",
        config = {
            mod_conv = 'm_kino_demonic', 
            max_highlighted = 1,
        },
        get_weight_mod = function()
            if G.GAME.kino_genre_weight["Horror"] and G.GAME.kino_genre_weight["Horror"] > 0 then
                return 2
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_demonic
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end
    }
end

if kino_config.romance_enhancement then
    SMODS.Consumable {
        key = "meetcute",
        set = "Tarot",
        order = 4,
        pos = {x = 3, y = 0},
        atlas = "kino_tarot",
        config = {
            mod_conv = 'm_kino_romance', 
            max_highlighted = 2,
        },
        get_weight_mod = function()
            if G.GAME.kino_genre_weight["Romance"] and G.GAME.kino_genre_weight["Romance"] > 0 then
                return 2
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_romance
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end
    }
end

SMODS.Consumable {
    key = "detective",
    set = "Tarot",
    order = 5,
    pos = {x = 4, y = 0},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_mystery', 
        max_highlighted = 2,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_mystery
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

if kino_config.spellcasting then
    SMODS.Consumable {
        key = "witch",
        set = "Tarot",
        order = 6,
        pos = {x = 5, y = 0},
        atlas = "kino_tarot",
        config = {
            mod_conv = 'm_kino_fantasy', 
            max_highlighted = 1,
        },
        get_weight_mod = function()
            if G.GAME.kino_genre_weight["Fantasy"] and G.GAME.kino_genre_weight["Fantasy"] > 0 then
                return 2
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_fantasy
            return {
                vars = {
                    self.config.max_highlighted
                }
            }
        end
    }
end

SMODS.Consumable {
    key = "gangster",
    set = "Tarot",
    order = 7,
    pos = {x = 0, y = 1},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_crime', 
        max_highlighted = 2,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_crime
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

SMODS.Consumable {
    key = "soldier",
    set = "Tarot",
    order = 8,
    pos = {x = 1, y = 1},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_action', 
        max_highlighted = 3,
    },
    get_weight_mod = function()
        if G.GAME.kino_genre_weight["Crime"] and G.GAME.kino_genre_weight["Crime"] > 0 then
            return 2
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_action
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}

SMODS.Consumable {
    key = "superhero",
    set = "Tarot",
    order = 9,
    pos = {x = 2, y = 1},
    atlas = "kino_tarot",
    config = {
        mod_conv = 'm_kino_superhero', 
        max_highlighted = 1,
    },
    get_weight_mod = function()
        if G.GAME.kino_genre_weight["Superhero"] and G.GAME.kino_genre_weight["Superhero"] > 0 then
            return 2
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_superhero
        return {
            vars = {
                self.config.max_highlighted
            }
        }
    end
}



-- Select a random joker and give money equal to its ROI
SMODS.Consumable {
    key = "producer",
    set = "Tarot",
    order = 10,
    pos = {x = 3, y = 1},
    atlas = "kino_tarot",
    config = {
        limit = 25,
        cost = 5,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.limit,
                self.config.cost
            }
        }
    end,
    can_use = function(self, card)
		return #G.jokers.highlighted == 1
			and G.jokers.highlighted[1].config.center.kino_joker
            and (to_big(G.GAME.dollars) >= to_big(G.GAME.bankrupt_at + 5))
	end,
    use = function(self, card)
        local _movie_info = G.jokers.highlighted[1].config.center.kino_joker
        ease_dollars(-1 * self.config.cost)

        -- calc profit
        if _movie_info.budget <= 100 then
            print(G.jokers.highlighted[1].config.center.key .. " has no registered budget and should be fixed")
            ease_dollars(self.config.cost)
            return
        end


        local reward = math.floor(self.config.cost * (_movie_info.box_office / _movie_info.budget))
        ease_dollars((reward <= self.config.limit) and reward or self.config.limit)
    end
}

-- if kino_config.actor_synergy then
--     SMODS.Consumable {
--         key = "award",
--         set = "Tarot",
--         order = 11,
--         pos = {x = 4, y = 1},
--         atlas = "kino_tarot",
--         config = {
--         },
--         loc_vars = function(self, info_queue, card)
--             return {
--                 vars = {
--                     self.config.max_highlighted
--                 }
--             }
--         end,
--         can_use = function(self, card)
--             return #G.jokers.highlighted == 1
--                 and G.jokers.highlighted[1].config.center.kino_joker
--         end,
--         use = function(self, card, area, copier)
--             if not G.jokers.highlighted[1].ability.kino_award then
--                 SMODS.Stickers['kino_award']:apply(G.jokers.highlighted[1], true)
--             else
--                 SMODS.Stickers['kino_award']:apply(G.jokers.highlighted[1], false)
--             end
--         end
--     }
-- end

SMODS.Consumable {
    key = "investor",
    set = "Tarot",
    order = 12,
    pos = {x = 4, y = 1},
    atlas = "kino_tarot",
    config = {
        investment_counters = 10
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_COUNTERS.counter_money
        return {
            vars = {
                self.config.investment_counters
            }
        }
    end,
	use = function(self, card, area, copier)
		for i = 1, card.ability.investment_counters do
            local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_investor"))
            -- Kino.change_counters(_target, "kino_investment", 1)
            _target:bb_counter_apply("counter_money", 1)
        end
    end,
    can_use = function(self, card)
        return true
    end
}

if kino_config.confection_mechanic then
SMODS.Consumable {
    key = "chef",
    set = "Tarot",
    order = 12,
    pos = {x = 5, y = 1},
    atlas = "kino_tarot",
    config = {
        cards_created = 2
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.cards_created
            }
        }
    end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
        for i = 1, math.min(self.config.cards_created, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local card = create_card('confection', G.consumeables, nil, nil, nil, nil, nil, 'che')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    used_consumable:juice_up(0.3, 0.5)
                end
                return true end }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
    end
}
end