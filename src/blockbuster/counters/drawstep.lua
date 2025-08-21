function create_UIBbox_counter_tooltip(card, scale)

    local textnode = {
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
                    n = G.UIT.C,
                    config = {
                        align = 'cm',
                        colour = G.C.CLEAR
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                text = "+",
                                colour = G.C.WHITE, 
                                scale = 0.4 * scale, 
                                shadow = false
                            }
                        }
                    }
                },
                {
                    n = G.UIT.C,
                    config = {
                        align = 'cm',
                        colour = G.C.CLEAR
                    },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.counter_config, 
                                ref_value = 'counter_num_ui', 
                                scale = 0.4 * scale, 
                                colour = G.C.WHITE
                            }
                        }
                    }
                }
            }
        }
    }

    local ui = {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            padding = 0.05,
            r = 0.05,
            colour = G.C.CLEAR,
        },
        nodes = textnode
        
    }

    return ui
end

function BlockbusterCounters.counter_ui_text(card)
    
    local scale = card.T.w/G.CARD_W 
    local y_val = -1
    if (card.ability.set == 'Default' or card.ability.set =='Enhanced') then
        y_val = 1
    end

    card.children.counter_ui_box = UIBox{
        definition = create_UIBbox_counter_tooltip(card, scale),
        config = {
            align = 'cm',
            offset = {
                x= (-0.65 * scale),
                y= (y_val * scale)}, 
            parent = card,
            bond = 'Strong',
        },
        states = {
            collide = {can = false},
            drag = {can = true}
        }
    }
end

SMODS.DrawStep {
    key = "counters_joker",
    order = 71,
    func = function(card, layer)
        if card and card.counter and card.counter_config and
        card.counter_config.counter_num_ui > 0 and 
        (card.ability.set ~= 'Default' and card.ability.set ~='Enhanced')  then

            -- Sprite
            G["shared_counters_joker"][card.counter.key].role.draw_major = card
            G["shared_counters_joker"][card.counter.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            
            if card.children and card.children.counter_ui_box then
                card.children.counter_ui_box.states.visible = true
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

SMODS.DrawStep {
    key = "counters_pcard",
    order = 71,
    func = function(card, layer)
        if card and card.counter and 
        card.counter_config.counter_num_ui > 0 and 
        (card.ability.set == 'Default' or card.ability.set =='Enhanced')  then

            G["shared_counters_pcard"][card.counter.key].role.draw_major = card
            G["shared_counters_pcard"][card.counter.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        
            if card.children and card.children.counter_ui_box then
                card.children.counter_ui_box.states.visible = true
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

SMODS.DrawStep {
    key = "counters_back",
    order = 71,
    func = function(card, layer)
        if card and card.counter and card.counter_config and
        card.counter_config.counter_num_ui > 0 then

            if card.children and card.children.counter_ui_box then
                card.children.counter_ui_box.states.visible = false
            end
        end
    end,
    conditions = {vortex = false, facing = 'back'}
}
