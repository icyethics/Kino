Blockbuster.Spellcasting.Spells = {}

Blockbuster.Spellcasting.Spell = SMODS.Center:extend({
    obj_table = Blockbuster.Spellcasting.Spells,
    obj_buffer = {},
    class_prefix = "spell",
    rng_buffer = {},
    set = "Spell",
    
    atlas = "blockbuster_spells",
    pos = {x = 0, y = 0},

    discovered = false,
    required_params = {
        "key",
    },
    suit_recipe = {
        -- Suit1 (string),
        -- Suit2 (string)

    },
    complex_recipe = {},
    always_cast_if_unlocked = false,
    spell_class = {},
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_spell'), G.C.PURPLE, G.C.WHITE, 1.2 )
    end,
    cast_spell = function(self, strength)
        local _obj = Blockbuster.Spellcasting.Spells[self.key]
        G.GAME.current_round.spells_cast = G.GAME.current_round.spells_cast + 1
        G.GAME.current_round.last_spell_cast.key = self.key
        G.GAME.current_round.last_spell_cast.strength = strength
        if _obj and _obj.cast and type(_obj.cast) == 'function' then
            local _returnval = _obj:cast()
            return _returnval
        end
        return true
    end
})