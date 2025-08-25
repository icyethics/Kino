--- Quest UI ---
Kino.create_quest_ui = function(card, quest_entry)
    if (not card.ability.extra.quests) 
    or (not card and not quest_entry) then 
        return {

        }
    end
    local _quest_nodes = {}


    local _iteration_list = quest_entry and quest_entry or card.ability.extra.quests

    -- SET QUEST TEXTS
    for _completed, _quest in pairs(_iteration_list) do
        local _box_colour = HEX("67504f")
        local _outline_colour = HEX("b2a6a6")
        local _sprite = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=1, y=1})
        local _tooltip = {text = "In-progress"}
        local _textcolour = G.C.BLACK
        if _quest.completion == true then
            _box_colour = HEX("4f6750")
            _outline_colour = HEX("b4c1b4")
            _sprite = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=2, y=1})
            _tooltip = {text = "Completed"}
            _textcolour = G.C.GREEN
        end

        local _text = _quest.alt_text and _quest.alt_text

        local _spritenode = {
            n = G.UIT.C,
            config = {
                minw = 0.3,
                minh = 0.3,
                maxw = 0.3,
                maxh = 0.3,
                align = 'cl',
                can_collide = false, 
                colour = _box_colour,
                outline = 0.8,
                outline_colour = _outline_colour,
                r = 0.2,
            },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        align = 'cl',
                        can_collide = false, 
                        object = _sprite, 
                        tooltip = _tooltip,
                        hover = true,
                        juice = true
                    }
                }
            }
        }

        local _subnodes = {}

        for _index, _text in ipairs(_quest.alt_text) do
            local _textnode = {
                n = G.UIT.R,
                config = {
                    align = 'cm',
                    colour = G.C.CLEAR,
                },
                nodes = {
                    {n = G.UIT.T,
                    config = {
                        text = _text,
                        colour = _textcolour, 
                        scale = 0.2, 
                        shadow = false
                    }}
                }  
            }

            _subnodes[#_subnodes + 1] = _textnode
        end


        local _node = {
            n = G.UIT.R,
            config = {
                align = 'cl',
                colour = G.C.CLEAR,
            },
            nodes = {
                _spritenode,
                {
                    n = G.UIT.C,
                    config = {
                        align = 'cm',
                        colour = G.C.CLEAR,
                    },
                    nodes = _subnodes
                }
            }
        }

        _quest_nodes[#_quest_nodes + 1] = _node
    end

    return {
        {
            n = G.UIT.C,
            config = {
                align = 'cm',
                colour = G.C.CLEAR,
                hover = true
            },
            nodes = _quest_nodes
        }
    }
end

Kino.create_legend_ui = function(card, legend_entry, current_rarity)
    if not legend_entry then 
        return {

        }
    end

    current_rarity = current_rarity and 6 - current_rarity or 6

    local _quest_nodes = {}


    local _iteration_list = legend_entry and legend_entry or card.ability.extra.legend

    -- SET QUEST TEXTS
    for _completed, _quest in pairs(_iteration_list) do
        local _box_colour = HEX("67504f")
        local _outline_colour = HEX("b2a6a6")
        local _sprite = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=1, y=1})
        local _tooltip = {text = "In-progress"}
        local _textcolour = G.C.GREY
        if _quest.completion == true then
            _box_colour = HEX("4f6750")
            _outline_colour = HEX("b4c1b4")
            _sprite = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=2, y=1})
            _tooltip = {text = "Completed"}
            _textcolour = G.C.GREEN
        end

        local _text = _quest.alt_text and _quest.alt_text

        local _spritenode = {
            n = G.UIT.C,
            config = {
                minw = 0.3,
                minh = 0.3,
                maxw = 0.3,
                maxh = 0.3,
                align = 'cl',
                can_collide = false, 
                colour = _box_colour,
                outline = 0.8,
                outline_colour = _outline_colour,
                r = 0.2,
            },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        align = 'cl',
                        can_collide = false, 
                        object = _sprite, 
                        tooltip = _tooltip,
                        hover = true,
                        juice = true
                    }
                }
            }
        }

        local _subnodes = {}

        for _index, _text in ipairs(_quest.alt_text) do
            local _textnode = {
                n = G.UIT.R,
                config = {
                    align = 'cm',
                    colour = G.C.CLEAR,
                },
                nodes = {
                    {n = G.UIT.T,
                    config = {
                        text = _text,
                        colour = _textcolour, 
                        scale = 0.2, 
                        shadow = false
                    }}
                }  
            }

            _subnodes[#_subnodes + 1] = _textnode
        end


        local _node = {
            n = G.UIT.R,
            config = {
                align = 'cl',
                colour = G.C.CLEAR,
            },
            nodes = {
                _spritenode,
                {
                    n = G.UIT.C,
                    config = {
                        align = 'cm',
                        colour = G.C.CLEAR,
                    },
                    nodes = _subnodes
                }
            }
        }

        _quest_nodes[#_quest_nodes + 1] = _node
    end


    local _textstart = localize("k_legend_willnot")

    if current_rarity > 3 then
        current_rarity = 4
    end

    local _rarity_names = {
        localize("k_common"),
        localize("k_uncommon"),
        localize("k_rare"),
        localize("k_legendary"),
    }

    local _rarity_node = {
        n = G.UIT.R,
        config = {
            align = 'cm',
            minw = 2,
            minh = 0.4,
            r = 0.1,
            padding = 0.03,
            emboss = 0.05,
            colour = G.C.RARITY[current_rarity],
        },
        nodes = { 
            {
                n = G.UIT.T,
                config = {
                    text = _rarity_names[current_rarity],
                    colour = G.C.WHITE, 
                    scale = 0.4, 
                    shadow = false
                }   
            }
        }
    }


    -- local _final_node = {
    --     n = G.UIT.R,
    --     config = {
    --         align = 'cm',
    --         colour = G.C.CLEAR,
    --     },
    --     nodes = {
    --         {
    --             n = G.UIT.T,
    --             config = {
    --                 text = _textstart,
    --                 colour = G.C.BLACK, 
    --                 scale = 0.3, 
    --                 shadow = false
    --             }
    --         },
    --         _rarity_node
    --     }  
    -- }

    _quest_nodes[#_quest_nodes + 1] = _rarity_node

    return {
        {
            n = G.UIT.C,
            config = {
                align = 'cm',
                colour = G.C.CLEAR,
                hover = true
            },
            nodes = _quest_nodes
        }
    }
end

--- Abduction UI ---
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
                            },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = "3",
                                        colour = G.C.WHITE, 
                                        scale = 0.4, 
                                        shadow = true
                                    }  
                                }
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

Kino.create_active_ui = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
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
                        align = 'cm',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                can_collide = false, 
                                object = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS["kino_ui_large"], {x=0, y=0}), 
                                tooltip = {text = "Active"}
                            },
                        }
                    }
                }
            }
        },
        config = {
            align = "cm",
            bond = 'Strong',
            parent = card,
        },
        states = {
            collide = {can = false},
            drag = { can = true }
        }
    }
end

-- TIMERS UI
Kino.create_timer_ui = function(card)
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
                                object = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=3, y=0}), 
                                tooltip = {text = "Timer"}
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

Kino.create_timer_ui_2 = function(card)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                instance_type= 'ALERT',
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
                        offset = {x=0,y=-1},
                        align = 'tr',
                        colour = G.C.CLEAR,
                        hover = true
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.ability.extra,
                                ref_value = "timer_num_non",
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

-- function ufo_sprite(pos, value)
--     local text_colour = G.C.BLACK

--     local t_s = Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=pos.x or 0, y=pos.y or 0})
--     t_s.states.drag.can = false
--     t_s.states.hover.can = false
--     t_s.states.collide.can = false
--     return {
--         n=G.UIT.C, 
--         config= {
--             align = "cm", 
--             padding = 0.07,
--             force_focus = true,  
--             focus_args = {type = 'sprite'}, 
--             tooltip = {text = "Abductions"}
--         }, 
--         nodes = {{
--             n= G.UIT.R, 
--             config = {
--                 align = "cm", 
--                 r = 0.1, 
--                 padding = 0.04, 
--                 emboss = 0.05, 
--                 colour = G.C.JOKER_GREY
--             }, 
--             nodes={{
--                 n = G.UIT.O, 
--                 config = {
--                     w = 0.5, 
--                     h = 0.5,
--                     can_collide = false, 
--                     object = t_s, 
--                     tooltip = {text = "Abductions"}
--                 }
--             }}
--         },
--         {
--             n = G.UIT.R, 
--             config = {
--                 align = "cm"
--             }, 
--             nodes = {{
--                 n = G.UIT.T, 
--                 config = {
--                     text = value,
--                     colour = text_colour, 
--                     scale = 0.4, 
--                     shadow = true
--                 }
--             },}
--         }}
--     }
-- end

--- CODE BASED ON THE card_ui.lua IMPLEMENTATION
--- FROM JOYOUSSPRING BY 'N
--- Creates UI to display genres above movie jokers
---@param card Card
---@return table
Kino.get_genre_text = function(card)
    local _scale_base = 0.8
    local _genres = card and card.config.center.k_genre or {}
    if #_genres < 1 then
        return {

        }
    end 

    local _full_text = ""
    local _genre_table = {}
    for i, _genre in ipairs(_genres) do
        _full_text = _full_text .. _genre
        if i < #_genres then
            _full_text = _full_text .. "|"
        end
    end

    for i, _genre in ipairs(_genres) do
        _genre_table[#_genre_table + 1] = {
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = {_genre},
                    colours = {G.ARGS.LOC_COLOURS[_genre]},
                    bump = true,
                    silent = true,
                    pop_in = 0,
                    pop_in_rate = 4,
                    maxw = 5,
                    shadow = true,
                    y_offset = 0,
                    spacing = math.max(0, 0.32 * (17 - #_full_text)),
                    scale = (0.4 - 0.004* #_full_text) * _scale_base
                })
            }
        }
    end
    local separator = {
        n = G.UIT.T,
        config = {
            text = "/",
            colour = G.C.UI.TEXT_LIGHT,
            scale = (0.4 - 0.004 * #_full_text) * _scale_base
        }
    }

    return {
        _genre_table[1],
        _genre_table[2] and separator or nil,
        _genre_table[2],
        _genre_table[3] and separator or nil,         
        _genre_table[3],
    }
end

---@param self table
---@param info_queue table
---@param card Card
---@param desc_nodes table
---@param specific_vars table
---@param full_UI_table table
Kino.generate_info_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)


    if not card or not card.ability then return end

    if card.ability.multipliers then
        local _multiplier = 1
        for _source, _mult in pairs(card.ability.multipliers) do
            _multiplier = _multiplier * _mult
        end

        if _multiplier > 1 then
            info_queue[#info_queue+1] = {set = 'Other', key = "kino_valuechange", vars = {_multiplier}}
        end

        if card.ability.last_actor_count and card.ability.last_actor_count > 1 then
            info_queue[#info_queue+1] = {set = 'Other', key = "kino_actor_synergy", vars = {card.ability.last_actor_count}}
        end
    end

    if card.ability.kino_additional_genres then
        
        if #card.ability.kino_additional_genres > 1 then
            local _genrestring = ""

            for i = 1, #card.ability.kino_additional_genres do
                if i == 1 then
                    _genrestring = _genrestring .. card.ability.kino_additional_genres[i]
                else

                    _genrestring = _genrestring .. ", " .. card.ability.kino_additional_genres[i]
                end
            end

            info_queue[#info_queue+1] = {set = 'Other', key = "kino_additional_genres", vars = {3}}
        end
    end
    

    full_UI_table.name = {
        {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.05 },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = full_UI_table.name
                },
                {
                    n = G.UIT.R,
                    config = { align = 'cm'},
                    nodes = Kino.get_genre_text(card)
                }

            }
        }
    }
end


-- -- local o_genui = SMODS.Center.generate_ui
-- local o_cardgenui = Card.generate_UIBox_ability_table
-- -- function SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
-- function Card.generate_UIBox_ability_table(vars_only)
--     -- o_genui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
--     o_cardgenui(self, vars_only)
--     local card = self

--     if not card or not card.ability then return end
--     print("test")

--     if card.ability.multipliers then
--         local _multiplier = 1
--         for _source, _mult in pairs(card.ability.multipliers) do
--             _multiplier = _multiplier * _mult
--         end

--         if _multiplier > 1 then
--             info_queue[#info_queue+1] = {set = 'Other', key = "synergy_mult", vars = {_multiplier}}
--         end
--     end

--     if card.ability.output_powerchange then
--         local _multiplier = 1
--         for _source, _mult in pairs(card.ability.output_powerchange) do
--             _multiplier = _multiplier * _mult
--         end

--         if _multiplier < 1 then
--             info_queue[#info_queue+1] = {set = 'Other', key = "output_powerchange", vars = {_multiplier}}
--         end
--     end

--     if card.ability.kino_additional_genres then
--         print("test")
        
--         if #card.ability.kino_additional_genres > 1 then
--             local _genrestring = ""

--             for i = 1, #card.ability.kino_additional_genres do
--                 if i == 1 then
--                     _genrestring = _genrestring .. card.ability.kino_additional_genres[i]
--                 else

--                     _genrestring = _genrestring .. ", " .. card.ability.kino_additional_genres[i]
--                 end
--             end

--             info_queue[#info_queue+1] = {set = 'Other', key = "kino_additional_genres", vars = _genrestring}
--         end
--     end
-- end

-- Confection card UI (Based on Cryptid's Code card implementation and Betmma's reserve implementation)
local o_uasbs = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local return_obj = o_uasbs(card)

    -- Pull cards
    if card.config.center.pull_button then
        if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then
            local sell = nil
            local use = nil
            local pull = nil

    --             if (card.area == G.pack_cards and G.pack_cards) then
    --   return {
    --     n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
    --       {n=G.UIT.R, config={mid = true}, nodes={
    --       }},
    --       {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.8*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
    --         {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
    --       }},
    --   }}
        -- pull =  {n=G.UIT.ROOT, 
        -- config = {padding = 0, colour = G.C.CLEAR}, nodes={
        --     {n=G.UIT.R, config={mid = true}, nodes={
        --     }},
        --     {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.8*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_pull_consumeable'}, nodes={
        --     {n=G.UIT.T, config={text = localize('b_kino_pull'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
        --     }},
        -- }}

        -- use = {n=G.UIT.C, 
        -- config={align = "cr"}, 
        -- nodes={
        --     {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
        --         {n=G.UIT.B, config = {w=0.1,h=0.6}},
        --         {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
        --     }}
        -- }}

        -- sell = nil

        -- Pull button
        -- Use only when in consumables or snackbag
        -- Sell Button only when in consumables or snackbag
            return {
				n = G.UIT.ROOT,
				config = { padding = -0.1, colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5*card.T.w - 0.15,
                            minh = 0.8*card.T.h, 
                            maxw = 0.7*card.T.w - 0.15,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "use_card",
							func = "can_pull_consumeable",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_kino_pull"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.55,
									shadow = true,
								},
							},
						},
					},
					-- { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					-- { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					-- { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					-- { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
					-- Betmma can't explain it, neither can I
				},
			}
        end
    end
    return return_obj
end

-- Info_queue update
local generate_UIBox_ability_tableref = Card.generate_UIBox_ability_table
function Card.generate_UIBox_ability_table(self, ...)
    local full_UI_table = generate_UIBox_ability_tableref(self, ...)

    if self.ability.output_powerchange then
        local _multiplier = 1
        for _source, _mult in pairs(self.ability.output_powerchange) do
            _multiplier = _multiplier * _mult
        end

        if _multiplier < 1 then
            generate_card_ui({set = 'Other', key = "output_powerchange", vars = {_multiplier}}, full_UI_table)
        end
    end

    -- if self.ability.kino_counter and self.ability.kino_numcounters > 0 then
    --     generate_card_ui({set = 'Other', key = self.ability.kino_counter .. "_counter", vars = {self.ability.kino_retrigger_counters}}, full_UI_table)
    -- end

    return full_UI_table
end

-- UI indicators
local blind_indicator_sprite
SMODS.DrawStep {
    key = "kino_blind_sprite",
    order = 50,
    func = function(card, layer)
        if G.GAME.current_round.boss_blind_indicator then
            if G.jokers and G.jokers.cards and G.jokers.cards[1] then
                if (G.GAME.current_round.boss_blind_indicator == 'kinoblind_vader' and card == G.jokers.cards[1]) or
                (G.GAME.current_round.boss_blind_indicator == 'kinoblind_palp' and card.area == G.jokers)
                then
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

local kino_monster_sprite
SMODS.DrawStep {
    key = "kino_monster_energy_indicator",
    order = 50,
    func = function(card, layer)
        if card.marked_by_monster then
                local _xOffset = 0
                local _yOffset = 1.75
                local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
                local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

                kino_monster_sprite = kino_monster_sprite or Sprite(0, -10, card.T.w, card.T.h, G.ASSET_ATLAS["kino_ui"], {x = 3, y = 1})
                kino_monster_sprite.role.draw_major = card
                kino_monster_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
                kino_monster_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
        end

        -- if card and card.children.back_uibox then
        --     card.children.back_uibox.states.visible = false
        -- end
    end,
    conditions = {vortex = false, facing = 'front'}
}

SMODS.DrawStep {
    key = "kino_active_indicator",
    order = 50,
    func = function(card, layer)
        if (card.ability.is_active or card.is_active) and
        G.jokers and G.jokers.cards and G.jokers.cards[1] == card then
                

                local kino_active_sprite = G.shared_enhancement_sprites.active_sprite
                kino_active_sprite.role.draw_major = card
                kino_active_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}
-- local textbox = nil
-- SMODS.DrawStep {
--     key = "kino_powerchange_indicator",
--     order = 51,
--     func = function(card, layer)
--         if card and card.ability and card.ability.output_powerchange then
--             local _multiplier = 1
--             for _source, _mult in pairs(card.ability.output_powerchange) do
--                 _multiplier = _multiplier * _mult
--             end
--             if _multiplier < 1 then
--                 local _xOffset = -0.25
--                 local _yOffset = 1.5
--                 G.shared_indicator_sprites.powerchange_sprite.role.draw_major = card
--                 G.shared_indicator_sprites.powerchange_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, -0.2, nil, _xOffset, _yOffset)
                
--                 textbox = textbox or UIBox {
--                     definition = {
--                         n = G.UIT.ROOT,
--                         config = {
--                             minh = 0.6,
--                             maxh = 1.2,
--                             minw = 0.6,
--                             maxw = 2,
--                             r = 0.001,
--                             padding = 0,
--                             align = 'lb',
--                             colour = G.C.CLEAR,
--                             shadow = false,
--                             ref_table = card
--                         },  
--                         nodes = { 
--                             {
--                                 n = G.UIT.O,
--                                 config = {
--                                     object = DynaText({
--                                         string = "2",
--                                         colours = G.C.WHITE,
--                                         bump = true,
--                                         silent = true,
--                                         maxw = 1,
--                                         shadow = true,
--                                         y_offset = 0
--                                     })
--                                 }
--                             }
--                         }
--                     },
--                     config = {
--                         align = "bli",
--                         bond = 'Strong',
--                         parent = card,
--                     },
--                     states = {
--                         collide = {can = false},
--                         drag = { can = true }
--                     }
--                 }
--                 textbox.role.draw_major = card
--                 textbox:draw_shader('dissolve', nil, nil, nil, card.children.center, -0.2, nil, _xOffset, _yOffset)


--             end
--         end
--     end,
--     conditions = {vortex = false, facing = 'front'}
-- }



-- ===== Card upgrade steps ===== --
-- SMODS.DrawStep {
--     key = "card_buff_reader",
--     order = 40,
--     func = function(self, layer)
--         if self and self.ability and self.ability.set == 'Default' then
--             if self.ability.perma_bonus > 0 then
--                 -- Add 
--                 if not self.children.card_buff_reader_perma_bonus then
--                     self.children.card_buff_reader_perma_bonus = Kino.create_upgrade_ui_element(self, G.C.CHIPS)
--                 end
--             end
--         end

--     end,
--     conditions = {vortex = false, facing = 'front'}
-- }

-- -- UIBox element
-- Kino.create_upgrade_ui_element = function(card, colour, type)
--     local _usedColour = colour or G.C.CHIPS

--     local returnUI = UIBox {
--         definition = {
--             n = G.UIT.ROOT,
--             config = {
--                 minh = 0.01,
--                 maxh = 2,
--                 minw = 0.01,
--                 maxw = 2,
--                 r = 0.001,
--                 padding = 0.05,
--                 align = 'cm',
--                 colour = _usedColour,
--                 shadow = false,
--                 ref_table = card
--             },
--             nodes = {
--                 {
--                     n = G.UIT.C,
--                     config = {
--                         align = 'cm',
--                         colour = G.C.CLEAR,
--                         hover = true
--                     },
--                     nodes = {
--                         {
--                             n = G.UIT.T,
--                             config = {
--                                 ref_table = card.ability,
--                                 ref_value = "perma_bonus",
--                                 colour = G.C.WHITE, 
--                                 scale = 0.2, 
--                                 shadow = true
--                             }  
--                         }
--                     }
--                 }
--             }
--         },
--         config = {
--             align = "cl",
--             bond = 'Strong',
--             parent = card,
--         },
--         states = {
--             collide = {can = false},
--             drag = { can = true }
--         }
--     }

--     return returnUI
-- end