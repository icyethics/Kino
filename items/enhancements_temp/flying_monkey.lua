SMODS.Enhancement {
    key = "flying_monkey",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 1},
    hidden = true,
    replace_base_card = true,
    overrides_base_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 0,
    config = {
        extra = {
            turns = 0,
        },
        
        x_chips = 0.9,
        x_mult = 0.9
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.x_chips,
                card.ability.x_mult,
                3 - card.ability.extra.turns
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- checks the three left most cards, and casts a random effect based on their suits.
        if context.main_scoring and context.cardarea == G.play then
            
            card.ability.extra.turns = card.ability.extra.turns + 1
            
        end

        if context.destroy_card and context.cardarea == G.play then
            if card.ability.extra.turns >= 3 and context.destroy_card == card then
                return {
                    remove = true
                } 
            end
        end
    end
}