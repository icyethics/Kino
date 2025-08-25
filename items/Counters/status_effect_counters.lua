BlockbusterCounters.Counter {
    key = "burn",
    prefix_config = {key = { mod = false}},
    order = 6,
    atlas = 'blockbuster_counters',
    
    pos = {x = 4, y = 2},

    config = {
        chance = 10,
        cap = 99
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.chance
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.main_scoring then
            if SMODS.pseudorandom_probability(card, 'bb_fire', card.counter_config.counter_num, 10, "card_destruction") then
                card.marked_to_destroy_by_fire_counter = true
            else
                card:bb_increment_counter(1)
            end
        end

        if context.destroying_card and context.destroying_card.marked_to_destroy_by_fire_counter then
            return { remove = true }
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
    key = "frost",
    prefix_config = {key = { mod = false}},
    order = 8,
    atlas = 'blockbuster_counters',
    pos = {x = 5, y = 2},
    config = {
        value_change = 0.5,
        cap = 10
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.value_change * 100,
            }
        }
    end,

    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            card:bb_increment_counter(-1)
        end
    end,

    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
        BlockbusterCounters.setpowerchange(card, self.key, self.config.value_change)
    end,
    remove_counter = function(self, card)
        BlockbusterCounters.setpowerchange(card, self.key, 1)
    end,
}


BlockbusterCounters.Counter {
    key = "paralysis",
    prefix_config = {key = { mod = false}},
    order = 7,
    atlas = 'blockbuster_counters',
    pos = {x = 6, y = 2},
    config = {
        cap = 10
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,

    calculate = function(self, card, context)
        if (context.before and context.cardarea == G.play) or 
        (context.before and context.cardarea == G.jokers) then
            if SMODS.pseudorandom_probability(card, 'bb_paralysis', card.counter_config.counter_num, 10, "card_debuff") then
                card:juice_up()
                card.bb_paralysis = true
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('bb_paralysis'), colour = G.C.MONEY })
            end
        end

        if context.after_debuff and context.ignore_debuff then
            card.bb_paralysis = false
            card:bb_increment_counter(-1)
        end
    end,

    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
        card.bb_paralysis = false
    end,
}

BlockbusterCounters.Counter {
    key = "sleep",
    prefix_config = {key = { mod = false}},
    order = 7,
    atlas = 'blockbuster_counters',
    pos = {x = 7, y = 2},
    config = {
        cap = 10
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,

    calculate = function(self, card, context)
        if context.after_debuff and context.ignore_debuff then
            if SMODS.pseudorandom_probability(card, 'bb_sleep', 1, card.counter_config.counter_num, "card_debuff") then
                card:bb_remove_counter("counter_effect")
            else
                card:bb_increment_counter(-1)
            end
        end
    end,

    increment = function(self, card, number)

    end,
    add_counter = function(self, card, number)
        SMODS.debuff_card(card, true, self.key)
    end,
    remove_counter = function(self, card)
        SMODS.debuff_card(card, false, self.key)
    end,
}

BlockbusterCounters.Counter {
    key = "drowsy",
    prefix_config = {key = { mod = false}},
    order = 7,
    atlas = 'blockbuster_counters',
    pos = {x = 8, y = 2},
    config = {
        chance = 10,
        cap = 10
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.chance
            }
        }
    end,

    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            if SMODS.pseudorandom_probability(card, 'bb_drowsy', card.counter_config.counter_num, self.config.chance, "card_transform") then
                card:bb_counter_apply("counter_sleep", card.counter_config.counter_num)
            else
                card:bb_increment_counter(1)
            end
            
        end
    end,

    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}

