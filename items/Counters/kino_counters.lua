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