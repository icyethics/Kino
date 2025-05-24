Kino.create_abduction_ui = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                minh = 0.6,
                maxh = 1.2,
                minw = 0.6,
                maxw = 2,
                r = 0.001,
                padding = 0,
                align = 'cm',
                colour = G.C.CLEAR,
                shadow = false,
                ref_table = card
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        minh = 1,
                        maxh = 1,
                        minw = 1,
                        maxw = 1,
                        align = 'tr',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                w = 1, 
                                h = 1,
                                can_collide = false, 
                                object = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=0, y=0}), 
                                tooltip = {text = "Abductions"}
                            }
                        }
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = 'Strong',
            parent = card,
        },
        states = {
            collide = {can = false},
            drag = { can = true }
        }
    }
end

Kino.create_abduction_ui_2 = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                minh = 1.3,
                maxh = 1.3,
                minw = 1,
                maxw = 1,
                r = 0.001,
                padding = 0,
                align = 'cm',
                colour = G.C.CLEAR,
                shadow = false,
                ref_table = card
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = 'tr',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.ability.extra,
                                ref_value = "num_cards_abducted_non",
                                colour = G.C.WHITE, 
                                scale = 0.3, 
                                shadow = true
                            }  
                        }
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = 'Strong',
            parent = card,
        },
        states = {
            collide = {can = false},
            drag = { can = true }
        }
    }
end

Kino.add_indicator = function(card, sprite_key, value_key, pref_loc, width, not_allowed_locs)

end

-- Indicators need to have: 
-- a sprite object to function as background
-- a value to be based off of
-- a DynaText object
-- A preferred location
-- forbidden location
-- A width
--

local blind_indicator_sprite
SMODS.DrawStep {
    key = "indicator_pass",
    order = 50,
    func = function(card, layer)
        if G.GAME.current_round.boss_blind_indicator then
            if G.jokers and G.jokers.cards and G.jokers.cards[1] then
                if card == G.jokers.cards[1] then
                    local _xOffset = 0.5
                    local _yOffset = 2.25
                    local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
                    local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

                    blind_indicator_sprite = blind_indicator_sprite or Sprite(0, -10, card.T.w, card.T.h, G.ASSET_ATLAS["kino_ui"], {x = 5, y = 0})
                    blind_indicator_sprite.role.draw_major = card
                    blind_indicator_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
                    -- blind_indicator_sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
                    -- blind_indicator_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, 0.1, nil, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + self.T.h*-0.2, nil, 0.6)
                    blind_indicator_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
                    -- blind_indicator_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, 0.1, nil, nil, self.T.h*-0.2)
                end
            else
            end
        end

        -- if card and card.children.back_uibox then
        --     card.children.back_uibox.states.visible = false
        -- end
    end,
    conditions = {vortex = false, facing = 'front'}
}

