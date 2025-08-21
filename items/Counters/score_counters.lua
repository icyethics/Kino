BlockbusterCounters.Counter {
    key = "mult",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 1,
    atlas = 'blockbuster_counters',
    config = {
        mult = 1
    },
    pos = {x = 0, y = 2},
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            local return_val = card.counter_config.counter_num * self.config.mult
            card:bb_increment_counter(-1)
            
            return {
                mult = return_val
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.mult
            }
        }
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}

BlockbusterCounters.Counter {
    key = "chip",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 2,
    atlas = 'blockbuster_counters',
    config = {
        chips = 10
    },
    pos = {x = 1, y = 2},
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main  then
            local return_val = card.counter_config.counter_num * self.config.chips
            card:bb_increment_counter(-1)
            return {
                chips = return_val
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.chips
            }
        }
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}

BlockbusterCounters.Counter {
    key = "xmult",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 3,
    atlas = 'blockbuster_counters',
    config = {
        xmult = 0.1
    },
    pos = {x = 2, y = 2},
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            local return_val = 1 + (card.counter_config.counter_num * 0.1)
            card:bb_increment_counter(-1)
            return {
                x_mult = return_val
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.xmult
            }
        }
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}
