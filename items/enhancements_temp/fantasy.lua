SMODS.Enhancement {
    key = "fantasy",
    atlas = "kino_enhancements",
    pos = { x = 4, y = 0},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        if G.hand and G.hand.cards and #G.hand.cards >= 3 then
            info_queue[#info_queue + 1] = Blockbuster.Spellcasting.Spells[Blockbuster.cards_to_spell_key(G.hand.cards)]
        end
        
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- checks the three left most cards, and casts a random effect based on their suits.
        if context.main_scoring and context.cardarea == G.play then
            
            if #G.hand.cards > 2 then
                local _result = Blockbuster.cast_spell_using_recipe(card, G.hand.cards)
                return _result
            end
        end
    end
}