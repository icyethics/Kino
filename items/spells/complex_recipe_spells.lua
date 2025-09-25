Blockbuster.Spellcasting.Spell {
    key = "fireball",
    order = 0,
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    atlas = "non_suit_spells",
    pos = {x = 0, y = 0},
    config = {
        x_mult = 5
    },
    loc_vars = function(self, info_queue, card)

    end,
    complex_recipe = {
        held_suits = {
            "Hearts",
            "Hearts",
            "Hearts",
            "Hearts",
            "Hearts"
        },
        consumables_held = {
            "c_sun"
        }
    },
    always_cast_if_unlocked = false,
    spell_class = {},
    cast = function(self, strength)
        -- These are just example spells! Potential future implementation, though
        print("I would cast fireball")
        -- return {
        --     x_mult = self.config.x_mult,
        --     message = "TRIGGERED FIRE"
        -- }
    end
}

Blockbuster.Spellcasting.Spell {
    key = "blizzard",
    order = 0,
    no_collection = true,
    prefix_config = {key = { mod = false, atlas = false}},
    atlas = "non_suit_spells",
    pos = {x = 1, y = 0},
    config = {
        x_mult = 5
    },
    loc_vars = function(self, info_queue, card)

    end,
    complex_recipe = {
        held_suits = {
            "Spades",
            "Spades",
            "Spades",
            "Spades",
            "Spades"
        },
        consumables_held = {
            "c_moon"
        }
    },
    always_cast_if_unlocked = true,
    spell_class = {},
    cast = function(self, strength)
        -- These are just example spells! Potential future implementation, though
        print("I would cast ice blast")
        -- return {
        --     x_chips = self.config.x_mult,
        --     message = "TRIGGERED FROST"
        -- }
    end
}