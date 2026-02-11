Blockbuster.Counters.Counter {
    key = "power",
    prefix_config = {key = { mod = true}},
    order = 1,
    atlas = 'blockbuster_counters',
    config = {
        power = 2
    },
    pos = {x = 2, y = 0},
    counter_class = {
        "beneficial",
        "value_manip",
    },
    calculate = function(self, card, context)
        if context.after and (context.cardarea == G.play or context.cardarea == G.jokers) then
            card:bb_increment_counter(-1)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (self.config.power - 1) * 100
            }
        }
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
        Blockbuster.manipulate_value(card, self.key, 2)
    end,
    remove_counter = function(self, card)
        Blockbuster.reset_value_multiplication(card, self.key)
    end,
}

Blockbuster.Counters.Counter {
    key = "blood",
    prefix_config = {key = { mod = true}},
    order = 1,
    atlas = 'kino_counters',
    config = {
    },
    pos = {x = 0, y = 0},
    counter_class = {
        "archetype",
    },
    calculate = function(self, card, context)

    end,
    loc_vars = function(self, info_queue, card)

    end,
    increment = function(self, card, number)
        inc_career_stat("kino_blood_counters_drained", number)
    end
}

Blockbuster.Counters.Counter {
    key = "heartbreak",
    prefix_config = {key = { mod = true}},
    order = 2,
    atlas = 'kino_counters',
    config = {
    },
    pos = {x = 1, y = 0},
    counter_class = {
        "archetype",
    },
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            card:bb_increment_counter(-card.ability.counter.counter_num )
        end
    end,
    loc_vars = function(self, info_queue, card)

    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
        if card.config.center == G.P_CENTERS.m_kino_sci_fi then
            check_for_unlock({type="kino_heartbreak_sci_fi"})
        end
    end,
}

Blockbuster.Counters.Counter {
    key = "bullet_pcard",
    prefix_config = {key = { mod = true}},
    order = 3,
    atlas = 'kino_counters',
    config = {
        retriggers = 1,
        cap = 6,
    },
    pos = {x = 2, y = 0},
    counter_class = {
        "enhancement",
    },
    pcard_only = true,
    calculate = function(self, card, context)
        if context.repetition and not card.ability.counter.applied_this_turn then
            local _retriggers = card.ability.counter.counter_num * self.config.retriggers
            card:bb_remove_counter("counter_effect")

            return {
                message = localize("k_again_ex"),
                repetitions = _retriggers
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (card.ability and card.ability.counter) and card.ability.counter.counter_num or 0,
                6
            }
        }
    end,
    increment = function(self, card, number)
        if (card.ability and card.ability.counter) and card.ability.counter.counter_num == 6 then
            check_for_unlock({type = "kino_john_wick_unlock", card = card})
        end
    end
}

Blockbuster.Counters.Counter {
    key = "bullet_joker",
    prefix_config = {key = { mod = true}},
    order = 3,
    atlas = 'kino_counters',
    config = {
        retriggers = 1,
        cap = 6,
    },
    no_collection = true,
    pos = {x = 2, y = 0},
    counter_class = {
        "enhancement",
    },
    joker_only = true,
    calculate = function(self, card, context)

    end,
    loc_vars = function(self, info_queue, card)

        if card.ability then print(card.ability) end
        return {
            vars = {
                (card.ability and card.ability.counter) and card.ability.counter.counter_num or 0,
                6
            }
        }
    end,
    increment = function(self, card, number)
        if (card.ability and card.ability.counter) and card.ability.counter.counter_num == 6 then
            check_for_unlock({type = "kino_john_wick_unlock", card = card})
        end
    end
}

Blockbuster.Counters.Counter {
    key = "drought",
    prefix_config = {key = { mod = true}},
    order = 4,
    atlas = 'kino_counters',
    config = {
        retriggers = 1,
        cap = 6,
    },
    pos = {x = 3, y = 0},
    counter_class = {
        "detrimental",
    },
    pcard_only = true,
    calculate = function(self, card, context)
        if context.modify_scoring_hand and context.other_card == card and
        context.in_scoring then
            return {
                remove_from_hand = true
            }
        end

        if context.main_scoring and context.cardarea == "unscored" then
            card:bb_increment_counter(-1)
        end

    end,
    loc_vars = function(self, info_queue, card)

        if card.ability then print(card.ability) end
        return {
            vars = {

            }
        }
    end,
    increment = function(self, card, number)
    end
}

Blockbuster.Counters.Counter {
    key = "glass",
    prefix_config = {key = { mod = true}},
    order = 4,
    atlas = 'kino_counters',
    config = {
        retriggers = 1,
        odds = 4,
    },
    pos = {x = 4, y = 0},
    counter_class = {
        "detrimental",
    },
    calculate = function(self, card, context)

        -- Joker destruction
        if context.after and context.cardarea == G.jokers then
            if SMODS.pseudorandom_probability(card, 'kino_glass_counter', 1, 4, "card_destruction") then
                if card.config.center.set == 'Joker' then
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            card.getting_sliced = true
                            card:shatter()
                            return true
                        end)
                    }))
                end
            else
                card:bb_increment_counter(-1)
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, 4, "card_destruction")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    increment = function(self, card, number)
    end
}


Blockbuster.Counters.Counter {
    key = "chain",
    prefix_config = {key = { mod = true}},
    order = 4,
    atlas = 'kino_counters',
    config = {

    },
    pos = {x = 5, y = 0},
    counter_class = {
        "detrimental",
    },
    calculate = function(self, card, context)
        -- if context.pre_discard then
        --     card:bb_increment_counter(-1)
        -- end
        -- if context.pre_discard then
        --     for _index, _pcard in ipairs(G.hand.highlighted) do
        --         if _pcard == card then
        --             G.hand:remove_from_highlighted(_pcard, true)
        --         end
        --     end
        --     print("testing testing testing")
        -- end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
        card.ability.cannot_be_discarded = true
    end,
    remove_counter = function(self, card)
        card.ability.cannot_be_discarded = nil
    end,
}