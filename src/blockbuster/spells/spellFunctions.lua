function Blockbuster.unlock_spell(spell_key)
    G.GAME.unlocked_spell_keys[#G.GAME.unlocked_spell_keys + 1] = spell_key
end
