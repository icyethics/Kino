SMODS.Joker {
    key = "black_panther",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stored_score = 0,
            stored_score_ui = 0,
            charges = 0,
            xmult = 0.5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = false,
    kino_joker = {
        id = 284054,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    k_genre = {"Superhero"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1]  = {set = 'Other', key = "gloss_active"}
        return {
            vars = {
                1,
                card.ability.extra.stored_score,
                Kino.black_panther_goal((G.GAME and G.GAME.round_resets) and G.GAME.round_resets.ante or 1),
                card.ability.extra.xmult,
                1 + card.ability.extra.charges * card.ability.extra.xmult
            }
        }
    end,
    in_pool = function(self)
        if G and G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
            return true
        end

    end,
    calculate = function(self, card, context)
        if context.final_scoring_step and 
        G.jokers.cards[1] == card and not context.blueprint then
            Kino.ease_chips_black_panther(card, card.ability.extra.stored_score_ui + (mult * hand_chips))
            card.ability.extra.stored_score = card.ability.extra.stored_score + (mult * hand_chips)

            mult = 0
            hand_chips = 0

            if card.ability.extra.stored_score + (mult * hand_chips) >= Kino.black_panther_goal(G.GAME.round_resets.ante) then
                card.ability.extra.charges = card.ability.extra.charges + 1
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
                    Kino.ease_chips_black_panther(card)
                return true end }))
                
                card.ability.extra.stored_score = 0
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main and 
        G.jokers.cards[1] ~= card and card.ability.extra.charges > 0 then
            return {
                x_mult = 1 + card.ability.extra.charges * card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss then
                card.ability.extra.stored_score = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end
        
    end,
    -- Unlock Functions
    unlocked = true,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_sci_fi_upgrades' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades >= 50 then
                unlock_card(self)
            end
        end
    end,
}

function Kino.black_panther_goal(ante)
    local amounts = {300,  800, 2000,  5000,  11000,  20000,   35000,  50000}
    local amount
    local k = 0.75
    if ante < 1 then
        amount = 100
    elseif ante <= 8 then
        amount = amounts[ante]
    else
        local a, b, c, d = amounts[8],1.6,ante-8, 1 + 0.2*(ante-8)
        local amount = math.floor(a*(b+(k*c)^d)^c)
    end
    
    return amount
end

function Kino.ease_chips_black_panther(card, mod)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            mod = mod or 0

            --Ease from current chips to the new number of chips
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blockable = false,
                ref_table = card.ability.extra,
                ref_value = 'stored_score_ui',
                ease_to = mod,
                delay =  0.3,
                func = (function(t) return math.max(math.floor(t),0) end)
            }))
            --Play a chip sound
            play_sound('chips2')
            return true
        end
      }))
end

SMODS.DrawStep {
    key = "kino_black_panter",
    order = 51,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS.j_kino_black_panther then
            if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
                if not card.children.black_panther_ui then
                    local _ui_node = {
                        n = G.UIT.ROOT,
                        config = {
                            align = "tm",
                            padding = 0.05,
                            r = 0.05,
                            colour = G.C.CLEAR,
                            -- {n=G.UIT.B, config = {w=0.1,h=3}},
                        },
                        nodes = {
                            {
                            n = G.UIT.C,
                            config = {
                                align = "cm",
                                padding = 0.05,
                                r = 0.05,
                                colour = G.C.CLEAR,
                            },
                            nodes = {
                                    
                                    {
                                        n = G.UIT.R,
                                        config = {
                                            align = "cm",
                                            padding = 0.05,
                                            r = 0.05,
                                            colour = G.C.CLEAR,
                                        },
                                        nodes = {
                                            {
                                                n = G.UIT.C,
                                                config = {
                                                    align = "cm",
                                                    padding = 0.05,
                                                    r = 0.05,
                                                    colour = G.C.BLACK,
                                                },
                                                nodes = {
                                                    {
                                                        n = G.UIT.R,
                                                        config = {
                                                            align = "cm",
                                                            padding = 0.05,
                                                            r = 0.05,
                                                            colour = G.C.BLACK,
                                                        },
                                                        nodes = {
                                                            {
                                                                n = G.UIT.T,
                                                                config = {
                                                                    text = localize("ph_blind_score_at_least"),
                                                                    colour = G.C.WHITE, 
                                                                    scale = 0.25, 
                                                                    shadow = false
                                                                }
                                                            }
                                                        }
                                                    },
                                                    {
                                                        n = G.UIT.R,
                                                        config = {
                                                            align = "cm",
                                                            padding = 0.05,
                                                            r = 0.05,
                                                            colour = G.C.BLACK,
                                                        },
                                                        nodes = {
                                                            {
                                                                n = G.UIT.O,
                                                                config = {
                                                                    w = 0.5, 
                                                                    h = 0.5,
                                                                    can_collide = false, 
                                                                    object = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["kino_black_panther_sprite"], {x = 0, y = 0}),
                                                                    tooltip = {text = "Black Panther Icon"}
                                                                }
                                                            },
                                                            {
                                                                n=G.UIT.O, 
                                                                config = {
                                                                    object = DynaText({
                                                                    string = tostring(Kino.black_panther_goal((G.GAME and G.GAME.round_resets) and G.GAME.round_resets.ante or 1)), colours = {G.C.RED}, bump = true,pop_in_rate = 5, silent = true, pop_delay = 0.5, scale = 0.4, min_cycle_time = 0})
                                                                }
                                                            },
                                                        }
                                                    },
                                                    {
                                                        n = G.UIT.R,
                                                        config = {
                                                            align = "cm",
                                                            padding = 0.05,
                                                            r = 0.05,
                                                            colour = G.C.L_BLACK,
                                                        },
                                                        nodes = {
                                                            {
                                                                n = G.UIT.O,
                                                                config = {
                                                                    w = 0.5, 
                                                                    h = 0.5,
                                                                    can_collide = false, 
                                                                    object = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["kino_black_panther_sprite"], {x = 0, y = 0}),
                                                                    tooltip = {text = "Black Panther Icon"}
                                                                }
                                                            },
                                                            {
                                                                n=G.UIT.O, 
                                                                config = {
                                                                    object = DynaText({
                                                                    string = {{prefix = "", ref_table = card.ability.extra, ref_value = "stored_score_ui"}}, colours = {G.C.RED}, bump = true,pop_in_rate = 5, silent = true, pop_delay = 0.5, scale = 0.4, min_cycle_time = 0})
                                                                }
                                                            },
                                                        }
                                                    },
                                                }
                                            }
                                        }
                                    },
                                }
                            }
                        }
                    }
                        

                    card.children.black_panther_ui = UIBox {
                        definition = _ui_node,
                        config = {
                            align = "cm",
                            bond = 'Strong',
                            parent = card,
                            offset = {x= 0, y=2},
                        },
                        states = {
                            collide = {can = false},
                            drag = { can = true }
                        }
                    }
                end
            else
                if card.children.black_panther_ui then
                    card.children.black_panther_ui = nil
                end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}