if not kino_config.spellcasting then return end

Kino.create_overylay_spell_showcase = function()

local _pool = {}
for i, v in pairs(SMODS.Spells) do
    if not v.no_collection then
        _pool[#_pool + 1] = v
    end
end

local _rows = {}

local _textnode = {
    n = G.UIT.R,
    config = {
        align = 'cm',
        padding = 0.05,
        colour = G.C.CLEAR
    },
    nodes = {
        {n = G.UIT.T,
            config = {
                text = "Spellbook",
                colour = G.C.WHITE, 
                scale = 0.5, 
                shadow = false
            }
        },
    }
}
-- table.insert(_rows, _textnode)
local _boxnode = {
    n = G.UIT.R,
    config = {
        align = 'cm',
        padding = 0.05,
        colour = G.C.CLEAR
    },
    nodes = {
        {n = G.UIT.B,
        config = {
            h = 0.3,
            w = 1
        }
        },
    }
}

-- table.insert(_rows, _boxnode)

local _textnode2 = {}

for i = 1, math.ceil(#_pool / 5) do
    local _spellarea = CardArea(
            0,
            0,
            G.CARD_W * 4.50,
            G.CARD_H * 1.1,
        {card_limit = 5, type = 'title', highlight_limit = 0, collection = true}
    )

    for j = 1, 5 do
        local _center = _pool[-5 + (i * 5) + j]

        if not _center then break end

        local _card = Card(
            _spellarea.T.x + _spellarea.T.w/2, 
            _spellarea.T.y, 
            G.CARD_W, 
            G.CARD_H, 
            nil, 
            _center,
            {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true}
        )

        _card.states.visible = true
        _card:start_materialize(nil, true)
        _spellarea:emplace(_card)
    end

    local _row = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            padding = 0.05,
            colour = G.C.CLEAR
        },
        nodes = {
                {n = G.UIT.O,
                config = {
                    object = _spellarea
                }
            }
        }
    }

    table.insert(_rows, _row)
end

local text = {
    {text = localize("k_kino_spellbook"), size = 0.5},
    {text = "Spells are constructed of three ingredients: a primary suit, a secondary suit, and a power rank.", size = 0.3},
    {text = "A spell is Cast when a spellcaster card or joker is triggered", size = 0.3},
}

-- Textbox generation
local _textnodes_upperbox = {}
local _titlenode = {
    n = G.UIT.R,
    config = {
        align = 'cm',
        colour = G.C.CLEAR
    },
    nodes = {
        {
            n = G.UIT.T,
            config = {
                text = localize("k_kino_spellbook"),
                colour = G.C.L_BLACK, 
                scale = 0.6, 
                shadow = false
            }
        },
    }
}
table.insert(_textnodes_upperbox, _titlenode)


for _index, _text in ipairs(localize("k_kino_spelltext")) do
    local _node = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = G.C.CLEAR
        },
        nodes = {
            {
                n = G.UIT.T,
                config = {
                    text = _text,
                    colour = G.C.L_BLACK, 
                    scale = 0.3, 
                    shadow = false
                }
            },
        }
    }
    table.insert(_textnodes_upperbox, _node)
end

local _textbox_explainer = {
    {
        n = G.UIT.C,
        config = {
            align = 'cm',
            padding = 0.05,
            r = 0.01,
            colour = G.C.CLEAR
        },
        nodes = _textnodes_upperbox
    }
}
-- == END OF Spellbook intro == --

-- Spell Level Explainer --
local _spellevel_text = {
    {power_level = 1, objects = "2, 3, 4, 5"},
    {power_level = 2, objects = "6, 7, 8, 9, 10"},
    {power_level = 3, objects = "Jack, Queen, King"},
    {power_level = 4, objects = "Ace"},
}

local _left_object = {}

local _titlenode = {
    n = G.UIT.R,
    config = {
        align = 'cm',
        colour = G.C.CLEAR
    },
    nodes = {
        {
            n = G.UIT.T,
            config = {
                text = localize("k_kino_spell_power"),
                colour = G.C.WHITE, 
                scale = 0.6, 
                shadow = false
            }
        }
    }
}
table.insert(_left_object, _titlenode)

for i = 1, #_spellevel_text do
    local _node = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = G.C.CLEAR
        },
        nodes = {
            {
                n = G.UIT.C,
                config = {
                    align = 'cm',
                    colour = G.C.CLEAR,
                    padding = 0.1
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            minh = 0.02,
                            align = 'cm',
                            colour = G.C.WHITE
                        },
                        nodes = {

                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = 'cm',
                            colour = G.C.CLEAR
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = localize("k_kino_power_level") .. _spellevel_text[i].power_level,
                                    colour = G.C.WHITE, 
                                    scale = 0.4, 
                                    shadow = false
                                }
                            }
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            align = 'cm',
                            colour = G.C.CLEAR
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = _spellevel_text[i].objects,
                                    colour = G.C.WHITE, 
                                    scale = 0.25, 
                                    shadow = false
                                }
                            }
                        },
                    },
                }
            }
        }
    }
    table.insert(_left_object, _node)
end

local _finalboxtext = {}

for _index, _text in ipairs(localize("k_kino_spell_power_text")) do
    local _node = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = G.C.CLEAR
        },
        nodes = {
            {
                n = G.UIT.T,
                config = {
                    text = _text,
                    colour = G.C.L_BLACK, 
                    scale = 0.25, 
                    shadow = false
                }
            }
        },
    }
    table.insert(_finalboxtext, _node)
end
-- Final Explainer box node
local _finalboxnode = {
    n = G.UIT.R,
    config = {
        align = 'cm',
        colour = G.C.WHITE,
        r = 0.05,
        minh = 1.6
    },
    nodes = {
        {
            n = G.UIT.C,
            config = {
                align = 'cm',
                colour = G.C.CLEAR,
                padding = 0.1
            },
            nodes = _finalboxtext
        }
    }
}

table.insert(_left_object, _finalboxnode)

-- == END OF Spellpower explainer == --

local t  = G.FUNCS.overlay_menu({
    definition = create_UIBox_generic_options({
        back_colour = G.C.RED,
        contents = {
            {
                n = G.UIT.C,
                -- nodes = _rows,
                nodes = {
                    -- Text box Nodes (Explainer)
                    {
                        n = G.UIT.R,
                        config = {
                            align = 'cm',
                            padding = 0.05,
                            r = 0.01,
                            colour = G.C.WHITE
                        },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    align = 'cm',
                                    padding = 0.05,
                                    r = 0.01,
                                    colour = G.C.CLEAR
                                },
                                nodes = _textbox_explainer,
                            }
                        }
                    },

                    -- Spell Power Node (Left) < > Spellbook Node (Right)
                    {
                        n = G.UIT.R,
                        config = {
                            align = 'cm',
                            padding = 0.05,
                            r = 0.01,
                            colour = G.C.CLEAR
                        },
                        nodes = {

                            -- Spell Power Node (Left)
                            {
                                n = G.UIT.C,
                                config = {
                                    align = 'lm',
                                    padding = 0.05,
                                    r = 0.01,
                                    colour = G.C.BLACK,
                                    minw = 3,
                                },
                                nodes = _left_object
                            },
                            -- Spellbook Node (Right)
                            {
                                n = G.UIT.C,
                                config = {
                                    align = 'rm',
                                    padding = 0.05,
                                    r = 0.01,
                                    colour = G.C.BLACK
                                },
                                nodes = _rows
                            },
                        }
                    },
                    -- Back Button Node? OPTIONAL???
                }},
        }}
    )
})

-- NOdes
-- GENERIC UIBox
    -- Column
        -- Explainer Row
        -- Content Row
        -- Back Button Row

return t

end

SMODS.Keybind({
    key_pressed = "s",
    action = function(self)
        local selected = G and G.CONTROLLER and
            (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end

        Kino.create_overylay_spell_showcase()
    end
})

