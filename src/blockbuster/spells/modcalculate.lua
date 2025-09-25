SMODS.current_mod.calculate = function(self, context)
    -- Casts spells that do not require a caster
    if context.individual and context.cardarea == G.play and
    context.scoring_hand[1] == context.other_card then
        local _result = Blockbuster.cast_unlocked_permanent_spells(context.other_card)
        return _result
    end
end