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
    end
}