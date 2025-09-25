local igo = Game.start_up
Game.start_up = function(self)
    local ret = igo(self)
    return ret
end

local _o_gsr = Game.start_run
function Game:start_run(args)
    local ret = _o_gsr(self, args)

    if G.GAME.starting_params.blockbuster_spellcasting_deck then
        Blockbuster.initialize_spellslingerdeck_UI()
    end
    return ret
end

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    for _key, _object in pairs(Blockbuster.Spellcasting.Spells) do
        if #_object.suit_recipe == 2 then
            Blockbuster.subscribe_spell_to_suits(_object.key, _object.suit_recipe[1], _object.suit_recipe[2])
        end

        if #_object.spell_class > 0 then
            Blockbuster.subscribe_spell_to_spelltable(_object.key, _object.spell_class)
        end

        if #_object.complex_recipe > 0 then
            Blockbuster.subscribe_spell_to_spelltable(_object.key, {"complex_recipe"})
        end

        if _object.always_cast_if_unlocked then
            Blockbuster.subscribe_spell_to_always_cast_table(_object.key, _object.always_cast_if_unlocked)
        end
    end

    ret.current_round.spells_cast = 0
    ret.current_round.last_spell_cast = {key = nil, strength = 0}
    ret.current_round.spell_queue = {
        -- should be {spell_key = KEY, strength = STRENGTH}
    }

    ret.unlocked_spell_keys = {
    }

    return ret
end