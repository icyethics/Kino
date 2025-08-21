BlockbusterCounters.Counter {
    key = "power",
    prefix_config = {key = { mod = true}},
    order = 1,
    atlas = 'blockbuster_counters',
    config = {
        power = 2
    },
    pos = {x = 2, y = 0},
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
        card:set_multiplication_bonus(card, self.key, 2)
    end,
    remove_counter = function(self, card)
        card:set_multiplication_bonus(card, self.key, 1, nil, 1 + 1)
    end,
}