function Blockbuster.cast_spell(spell_key, strength, repeatable)
    if repeatable == nil then
        repeatable = true
    end
    if not strength then strength = 1 end

    if strength <= 0 then strength = 1 end
    if strength >= 5 then strength = 4 end

    if not Blockbuster.Spellcasting.Spells then
        print("Mod error: no spells to index")
        return {

        }
    end

    SMODS.calculate_context({bb_pre_spell_cast = true, strength = strength, spell_key = spell_key, repeatable = repeatable})

    G.GAME.current_round.spells_cast = G.GAME.current_round.spells_cast + 1
    G.GAME.current_round.last_spell_cast.key = spell_key
    G.GAME.current_round.last_spell_cast.strength = strength

    if #G.GAME.current_round.spell_queue > 0 then
        local _nextspell = G.GAME.current_round.bb_spell_queue[1]
        spell_key = _nextspell.spell_key
        strength = _nextspell.strength
        table.remove(G.GAME.current_round.bb_spell_queue, 1)
    end

    local _return_table = Blockbuster.Spellcasting.Spells[spell_key]:cast(strength)

    SMODS.calculate_context({bb_cast_spell = true, strength = strength, spell_key = spell_key, repeatable = repeatable})

    if type(_return_table) == 'table' then
        return _return_table
    end
    return {

    }
end

-- Cast random spell
-- Cast spell based on hand
-- Suit spells are always unlocked
-- Complex recipes take precedence
function Blockbuster.cast_spell_using_recipe(caster, list_of_cards)
    if type(list_of_cards) ~= "table" then
        print("Cards given were not a table!")
    end

    if #list_of_cards <= 2 then
        return {}
    end

    local _spellkey = Blockbuster.cards_to_spell_key(list_of_cards)
    local spellstrength = Blockbuster.card_to_spell_level(list_of_cards[3])
    
    -- Overwrite spellkey potentially if complex recipe present
    for _index, _spellkey_check in ipairs(G.GAME.unlocked_spell_keys) do
        if Blockbuster.Spellcasting.Spells[_spellkey_check] and 
        Blockbuster.Spellcasting.Spells[_spellkey_check].always_cast_if_unlocked == false and
        Blockbuster.complex_recipe_check(_spellkey_check) then
            _spellkey = _spellkey_check
        end
    end

    return Blockbuster.cast_spell(_spellkey, spellstrength)
end

function Blockbuster.cast_unlocked_permanent_spells(caster)
    local _spellkey = nil
    for _index, _spellkey_check in ipairs(G.GAME.unlocked_spell_keys) do

        if Blockbuster.Spellcasting.Spells[_spellkey_check] and 
        Blockbuster.Spellcasting.Spells[_spellkey_check].always_cast_if_unlocked == true and
        Blockbuster.complex_recipe_check(_spellkey_check) then
            _spellkey = _spellkey_check
        end
    end

    if _spellkey then
        return Blockbuster.cast_spell(_spellkey, spellstrength)
    end
end

function Blockbuster.cards_to_spell_key(list_of_cards)
    if #list_of_cards <= 1 then
        return "spell_None_None"
    end

    local suit1 = Blockbuster.card_to_spell_suit(list_of_cards[1])
    local suit2 = Blockbuster.card_to_spell_suit(list_of_cards[2])

    if suit1 == "None" or suit2 == "None" then
        return "spell_None_None"
    end

    local _spellkey = "spell_None_None"
    if type(Blockbuster.SuitSpelltable[suit1]) == 'table' then
        _spellkey = Blockbuster.SuitSpelltable[suit1][suit2]
    end

    if type(_spellkey) == 'string' then
        return _spellkey
    else    
        print("Spellcasting Failed: issues with Spelltable")
        return "spell_None_None"
    end
end

function Blockbuster.card_to_spell_suit(playing_card)
    local suit = playing_card.base.suit
    if SMODS.has_no_suit(playing_card) then
        suit = "None"
    elseif SMODS.has_any_suit(playing_card) then
        suit = "Wild"
    end
    if Blockbuster.valid_spellsuits[suit] then
        return suit
    else
        return "None"
    end

    return suit
end

function Blockbuster.card_to_spell_level(playing_card)
    local strength = 1
    if SMODS.has_no_rank(playing_card) then
        strength = 1
    else
        strength = Blockbuster.id_to_spell_level(playing_card:get_id())
    end

    return strength
end

function Blockbuster.id_to_spell_level(playing_card_id)
    if playing_card_id <= 0 then
        -- Failsafe against custom ranks
        return 1
    end
    if playing_card_id >= 1 and playing_card_id <= 5 then
        return 1
    end
    if playing_card_id >= 6 and playing_card_id <= 10 then
        return 2
    end
    if playing_card_id >= 11 and playing_card_id <= 13 then
        return 3
    end
    if playing_card_id == 14 then
        return 4
    end
    if playing_card_id >= 15 then
        -- Failsafe against custom ranks
        return 4
    end
end

function Blockbuster.complex_recipe_check(spell_key)
    -- check each parameter and then cast depending on its truth value
    local _spell = Blockbuster.Spellcasting.Spells[spell_key]
    local _recipe = _spell.complex_recipe 
    local _successful_checks = {}

    -- Held Suits
    if _recipe.held_suits then
        _successful_checks.held_suits = false
        local _number_of_tests = 0
        local _hash = {}
        for _index, _pcard in ipairs(G.hand.cards) do
            local _is_match = false
            for _index2, _held_suit in ipairs(_recipe.held_suits) do
                if not _hash[_index] and 
                Blockbuster.card_to_spell_suit(_pcard) == _held_suit then
                    _hash[_index] = true
                    _is_match = true
                    _number_of_tests = _number_of_tests + 1
                end
            end
        end

        if _number_of_tests >= #_recipe.held_suits then
            _successful_checks.held_suits = true
        end
    end

    -- Played Suits
    if _recipe.played_suits then
    _successful_checks.played_suits = false
        local _number_of_tests = 0
        local _hash = {}
        for _index, _pcard in ipairs(G.play.cards) do
            local _is_match = false
            for _index2, _played_suit in ipairs(_recipe.played_suits) do
                if not _hash[_index] and 
                Blockbuster.card_to_spell_suit(_pcard) == _played_suit then
                    _hash[_index] = true
                    _is_match = true
                    _number_of_tests = _number_of_tests + 1
                end
            end
        end

        if _number_of_tests >= #_recipe.played_suits then
            _successful_checks.played_suits = true
        end
    end

    -- Held Ranks
    if _recipe.held_ranks then
    _successful_checks.held_ranks = false
        local _number_of_tests = 0
        local _hash = {}
        for _index, _pcard in ipairs(G.hand.cards) do
            local _is_match = false
            for _index2, _held_rank in ipairs(_recipe.held_ranks) do
                if not _hash[_index] and 
                _pcard:get_id() == _held_rank then
                    _hash[_index] = true
                    _is_match = true
                    _number_of_tests = _number_of_tests + 1
                end
            end
        end

        if _number_of_tests >= #_recipe.held_suits then
            _successful_checks.held_suits = true
        end
    end
    
    -- Played Ranks
    if _recipe.played_ranks then
    _successful_checks.played_ranks = false
        local _number_of_tests = 0
        local _hash = {}
        for _index, _pcard in ipairs(G.play.cards) do
            local _is_match = false
            for _index2, _played_rank in ipairs(_recipe.played_ranks) do
                if not _hash[_index] and 
                _pcard:get_id() == _played_rank then
                    _hash[_index] = true
                    _is_match = true
                    _number_of_tests = _number_of_tests + 1
                end
            end
        end

        if _number_of_tests >= #_recipe.played_ranks then
            _successful_checks.played_ranks = true
        end
    end 

    -- Held Consumables
    if _recipe.consumables_held then
        local _number_of_tests = 0
        local _hash = {}
        _successful_checks.consumables_held = false
        for _index, _consumable in ipairs(G.consumeables.cards) do
            local _is_match = false
            for _index2, _consumable_held in ipairs(_recipe.consumables_held) do

                if not _hash[_index] and
                _consumable.config.center.key == _consumable_held then
                    _hash[_index] = true
                    _is_match = true
                    _number_of_tests = _number_of_tests + 1
                end
            end
        end

        if _number_of_tests >= #_recipe.consumables_held then
            _successful_checks.consumables_held = true
        end
    end

    for _key, _value in pairs(_successful_checks) do
        if _value == false then
            return false
        end
    end

    return true

end
