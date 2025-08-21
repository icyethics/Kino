BlockbusterCounters.Counter {
    key = "retrigger",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 4,
    atlas = 'blockbuster_counters',
    pos = {x = 0, y = 0},
    config = {
        retriggers = 1,
        cap = 9,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.retriggers
            }
        }
    end,
    calculate = function(self, card, context)
        if card.ability.set ~= 'Joker' 
        and context.repetition then
            local _retriggers = card.counter_config.counter_num * self.config.retriggers
            card:bb_increment_counter(-1)

            return {
                message = localize("k_again_ex"),
                repetitions = _retriggers
            }

        elseif context.retrigger_joker_check and 
        context.other_card and
        context.other_card ~= self then
            
            
            local _retriggers = card.counter_config.counter_num * self.config.retriggers
            card:bb_increment_counter(-1)
            
            return {
                message = localize("k_again_ex"),
                repetitions = _retriggers
            }
        end
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}

BlockbusterCounters.Counter {
    key = "investment",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 5,
    atlas = 'blockbuster_counters',
    pos = {x = 1, y = 0},
    config = {
        money = 1,
        cap = 9,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.money
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            local return_val = card.counter_config.counter_num * self.config.money
            card:bb_increment_counter(-1)
            return {
                dollars = return_val
            }
        end
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}

BlockbusterCounters.Counter {
    key = "money",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 5,
    atlas = 'blockbuster_counters',
    pos = {x = 3, y = 2},
    config = {
        money = 1,
        cap = 9,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.money
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            local return_val = card.counter_config.counter_num * self.config.money
            card:bb_increment_counter(-1)
            return {
                dollars = return_val
            }
        end
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}