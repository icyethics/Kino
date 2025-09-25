Blockbuster.Spellcasting.Spell {
    key = "EyeOfAgamoto",
    order = 16,
    atlas = "kino_spells",
    pos = {x = 4, y = 1},
    config = {
        target = "unique",
        hands_gained = 2
    },
    loc_vars = function(self, info_queue, card)
        return {
            self.config.hands_gained
        }
    end,
    no_collection = true,
    cast = function(self, strength)
        G.E_MANAGER:add_event(Event({func = function()
            ease_hands_played(self.config.hands_gained)
        return true end }))
        return {
            message = localize('k_drstrange'),
            colour = G.C.GREEN
        }
    end
}