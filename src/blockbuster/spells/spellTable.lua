-- ====
-- Suit Spell table
-- ====

function Blockbuster.subscribe_spell_to_suits(spell, suit1, suit2, nonsymmetrical)
    if not Blockbuster.SuitSpelltable[suit1] then
        Blockbuster.SuitSpelltable[suit1] = {}
        Blockbuster.valid_spellsuits[suit1] = true
    end

    Blockbuster.SuitSpelltable[suit1][suit2] = spell
    
    if not nonsymmetrical then
        Blockbuster.subscribe_spell_to_suits(spell, suit2, suit1, true)
    end
end

function Blockbuster.get_spell_by_suits(suit1, suit2)
    if Blockbuster.SuitSpelltable[suit1] then
        if Blockbuster.SuitSpelltable[suit1][suit2] then
            return Blockbuster.SuitSpelltable[suit1][suit2]
        end
    end

    print("No valid spell registered")
    -- RETURN DUMMY SPELL
end

Blockbuster.SuitSpelltable = {
    -- DUMMY ENTRY
    -- [SUIT 1] = {
    -- [SUIT 1.1] = SPELL KEY
    --}
}

-- ====
-- Generic Spell table
-- ====

-- spell is a key (string object)
function Blockbuster.subscribe_spell_to_spelltable(spell, spellclass_table)
    for _index, _quality in ipairs(spellclass_table) do
        if not Blockbuster.GeneralSpelltable[_quality] then
            Blockbuster.GeneralSpelltable[_quality] = {}
        end
        Blockbuster.GeneralSpelltable[_quality][#Blockbuster.GeneralSpelltable[_quality] + 1] = spell
    end
end

function Blockbuster.subscribe_spell_to_always_cast_table(spell, always_cast)
    if always_cast == true then
        if not Blockbuster.GeneralSpelltable.always_cast then
            Blockbuster.GeneralSpelltable.always_cast = {}
        end

        Blockbuster.GeneralSpelltable.always_cast[#Blockbuster.GeneralSpelltable.always_cast + 1] = spell
    end
end

Blockbuster.GeneralSpelltable = {
    
}

Blockbuster.valid_spellsuits = {

}