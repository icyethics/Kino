SMODS.Joker {
    key = "prestige",
    order = 103,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- when you play a hand with only a lucky card,
        -- destroy it and create a copy
        -- with all odds increased by 1
    end
}