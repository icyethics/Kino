-- Draw the textbox

-- Update the textbox

function Kino.generate_spellslingerdeck_UI(spell_key)
    local _text_title = localize{type = 'name_text', set = 'Spell', key = spell_key or "spell_kino_None_None"}
    local _text_description = localize{type = 'descriptions', set = 'Spell', key = spell_key or "spell_kino_None_None"}

    local _text_description_nodes = {
        {
            n = G.UIT.R,
            config = {
                align = 'cm',
                padding = 0.05,
                r = 0.01,
                colour = G.C.CLEAR
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = _text_title,
                        colour = G.C.WHITE, 
                        scale = 0.5, 
                        shadow = false
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = {
                align = 'cm',
                padding = 0.05,
                r = 0.01,
                colour = G.C.WHITE
            },
            nodes = _text_description
        }
    }

    -- for _index, _text in ipairs(_text_description) do
    --     local _textnode_base = {
    --         n = G.UIT.R,
    --         config = {
    --             align = 'cm',
    --             padding = 0.05,
    --             r = 0.01,
    --             colour = G.C.WHITE
    --         },
    --         nodes = {
    --             {
    --                 n = G.UIT.T,
    --                 config = {
    --                     text = _text,
    --                     colour = G.C.L_BLACK, 
    --                     scale = 0.25, 
    --                     shadow = false
    --                 }
    --             }
    --         },
    --     }

    --     _text_description_nodes[#_text_description_nodes + 1] = _textnode_base
    -- end



    local ui = {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            padding = 0.05,
            r = 0.05,
            colour = G.C.BLACK,
        },
        nodes = _text_description_nodes
        
    }

    return ui
end


-- create_UIBox_detailed_tooltip
function Kino.initialize_spellslingerdeck_UI()
    local full_UI_table = {
        main = {},
        info = {},
        type = {},
        name = 'done',
        badges = {}
    }
    -- print(G.P_CENTERS["spell_kino_None_None"])
    -- print(SMODS.Spells["spell_kino_None_None"])

    -- G.GAME.kino_ssd_UI = create_UIBox_detailed_tooltip(SMODS.Spells["spell_kino_None_None"])

    G.GAME.kino_ssd_UI = UIBox{
        definition = create_UIBox_detailed_tooltip(SMODS.Spells["spell_kino_None_None"]),
        config = {
            align = 'cm',
            offset ={x=0.3,y=-2.5}, 
            major = G.deck,
            instance_type = 'ALERT',
        }
    }
    G.GAME.kino_ssd_UI_current_spell = "spell_kino_None_None"
end

function Kino.update_spellslingerdeck_UI()
    if not G.GAME.kino_ssd_UI then return end

    -- Gather the spell
    local _key = check_spell_key(G.hand.cards)
    if _key == G.GAME.kino_ssd_UI_current_spell then return end
    
    G.GAME.kino_ssd_UI:remove()
    G.GAME.kino_ssd_UI = nil

    -- G.GAME.kino_ssd_UI = create_UIBox_detailed_tooltip(SMODS.Spells[_key])
    G.GAME.kino_ssd_UI = UIBox{
        definition = create_UIBox_detailed_tooltip(SMODS.Spells[_key]),
        config = {
            align = 'cm',
            offset ={x=0.3,y=-2.5}, 
            major = G.deck,
            instance_type = 'ALERT',
        }
    }
end

function Kino.debugfunc_spell()
    Kino.update_spellslingerdeck_UI()
end