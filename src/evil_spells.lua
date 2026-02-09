function Kino.update_saruman_UI()
    if not G.GAME.saruman_blockbuster_ssd_UI or not G.GAME.saruman_blockbuster_ssd_UI.remove 
    or not G.hand or (G.hand and G.hand.cards and #G.hand.cards <= 1) then 
        return 
    end

    -- Gather the spell
    local _suitcard = G.hand.cards[1]
    local _suit = "Wild"
    if Blockbuster.valid_spellsuits[_suitcard.base.suit] then
        _suit = _suitcard.base.suit
    end

    local _key = "spell_kino_evil_" .. _suit
    local _spellstrength = Blockbuster.card_to_spell_level(G.hand.cards[2])

    
    
    G.GAME.saruman_blockbuster_ssd_UI:remove()
    G.GAME.saruman_blockbuster_ssd_UI = nil
    G.GAME.saruman_blockbuster_ssd_UI_current_spell = _key
    
    G.GAME.saruman_blockbuster_ssd_UI = UIBox{
        definition = create_UIBox_detailed_tooltip(Blockbuster.Spellcasting.Spells[_key]),
        config = {
            align = 'cm',
            offset ={x=0.3,y=-2.5}, 
            major = G.deck,
            instance_type = 'ALERT',
        }
    }
end

function Blockbuster.initialize_spellslingerdeck_UI()
    local full_UI_table = {
        main = {},
        info = {},
        type = {},
        name = 'done',
        badges = {}
    }

    G.GAME.saruman_blockbuster_ssd_UI = UIBox{
        definition = create_UIBox_detailed_tooltip(Blockbuster.Spellcasting.Spells["spell_None_None"]),
        config = {
            align = 'cm',
            offset ={x=0.3,y=-2.5}, 
            major = G.deck,
            instance_type = 'ALERT',
        }
    }
    G.GAME.saruman_blockbuster_ssd_UI_current_spell = "spell_None_None"
end

function Kino.cast_evil_spell_using_recipe(caster, list_of_cards)
    if #list_of_cards <= 1 then
        return
    end

    local _suitcard = list_of_cards[1]
    local _suit = "Wild"
    if SMODS.has_no_suit(_suitcard) or SMODS.has_any_suit(_suitcard) then
        _suit = "Wild"
    elseif Blockbuster.valid_spellsuits[_suitcard.base.suit] then
        _suit = _suitcard.base.suit
    end

    local _spellkey = "spell_kino_evil_" .. _suit
    local _spellstrength = Blockbuster.card_to_spell_level(list_of_cards[2])

    return Blockbuster.cast_spell(_spellkey, _spellstrength)
end