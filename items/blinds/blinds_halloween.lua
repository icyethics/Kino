-- FABRICATION MACHINE

SMODS.Atlas {
    key = "kinoween_fabrication_machine",
    atlas_table = "ANIMATION_ATLAS",
    path = "kinoween_fabrication_machine.png",
    px = 34,
    py = 34,
    frames = 21
}

SMODS.Atlas {
    key = "kino_enhancement_fabrication",
    px = 71,
    py = 95,
    path = "kinoween_fabricated_enhancement.png"
}


SMODS.Blind{
    key = "fabrication_machine",
    dollars = 10,
    mult = 2,
    boss_colour = HEX('90866d'),
    atlas = 'kinoween_fabrication_machine', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    no_collection = true,
    debuff = {

    },
    in_pool = function(self)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end,
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)


    end,
    set_blind = function(self)
        local _suits = SMODS.Suits
        local _cardsset = 0
        for _suitname, _suitdata in pairs(_suits) do
            local _valid_targets = {}
            local _secondary_targets = {}
            for _index, _pcard in ipairs(G.playing_cards) do
                if _pcard:is_suit(_suitname) then
                    if _pcard.config.center ~= G.P_CENTERS.c_base then
                        _secondary_targets[#_secondary_targets + 1] = _pcard
                    else
                        _valid_targets[#_valid_targets + 1] = _pcard
                    end
                end
            end

            if #_valid_targets > 0 or #_secondary_targets > 0 then
                local _true_target_table = #_valid_targets > 0 and _valid_targets or _secondary_targets
                local _target = pseudorandom_element(_true_target_table, pseudoseed("kino_blind_fabmach"))
                _target:set_ability("m_kino_fabricated_monster")
                _cardsset = _cardsset + 1
            end
        end



        G.E_MANAGER:add_event(Event({
            func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        attention_text({
                            text = localize('k_blind_fabrication_machine'),
                            scale = 1.3, 
                            hold = 1.4,
                            major = G.play,
                            align = 'tm',
                            offset = {x = 0, y = -1},
                            silent = true
                        })
                        return true
                    end
                }))
                return true
            end
        }))
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)

    end,
    calculate = function(self, blind, context)

    end
}

SMODS.Enhancement {
    key = "fabricated_monster",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 3},
    no_collection = true,
    hidden = true,
    config = {
        extra = {
            level_non = 1,
            score_mod = 0.8
        }
    },
    loc_vars = function(self, info_queue, card)
        local key
        local vars = {}
        if card.ability.extra.level_non == 3 then
            key = self.key .. "_3"
            vars = {
                card.ability.extra.score_mod,
                card.ability.extra.score_mod
            }
        elseif card.ability.extra.level_non then
            key = self.key .. "_2"
            vars = {
                card.ability.extra.score_mod
            }
        else
            key = self.key .. "_1"
            vars = {
                card.ability.extra.score_mod
            }
        end
        return { key = key, vars = vars}

    end,
    calculate = function(self, card, context, effect)
        -- Level 1: x0.8 mult while in hand. Upgrades if card with same rank in hand
        -- Level 2: x0.8 mult, can't discard. Upgrades if card with same suit in hand
        -- Level 3: x0.8 mult, x0.8 chips, can't discard.

        -- While in hand, do negatives
        if context.main_scoring and context.cardarea == G.hand then
            if card.ability.extra.level_non >= 1 then
                if card.ability.extra.level_non == 3 then
                    return {
                        x_mult = card.ability.extra.score_mod,
                        x_chips = card.ability.extra.score_mod
                    }
                end

                return {
                    x_mult = card.ability.extra.score_mod,
                }
            end
        end

        if context.after and context.cardarea == G.hand then
            local level_up = false
            if card.ability.extra.level_non == 1 then
                for _i, _pcard in ipairs(G.hand.cards) do
                    if _pcard ~= card and card:get_id() == _pcard:get_id() then
                        level_up = true
                        break
                    end
                end
            end

            if card.ability.extra.level_non == 2 then
                for _index, _pcard in ipairs(G.hand.cards) do
                    local _suits = SMODS.Suits
                    for _suitname, _suitdata in pairs(_suits) do
                        if _pcard ~= card and _pcard:is_suit(_suitname) and card:is_suit(_suitname) then
                            level_up = true
                            break
                        end
                    end
                end
            end

            if level_up then
                G.E_MANAGER:add_event(Event({
                func = function()
                    card:flip()
                    card.ability.extra.level_non = card.ability.extra.level_non + 1

                    delay(0.2)
                    card:flip()
                    
                    return true
                end}))
            end
        end

        -- Cleanse 1 level off if it scores
        if context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({
            func = function()
                card:flip()
                card.ability.extra.level_non = card.ability.extra.level_non -1

                if card.ability.extra.level_non == 0 then
                    card:set_ability(G.P_CENTERS.c_base, nil, true)
                end
                delay(0.2)
                card:flip()
                
                return true
            end}))
        end
    end
}

local level1, level2, level3
local blinking_level2
local blinking_level3_1, blinking_level3_2, blinking_level3_3
SMODS.DrawStep {
    key = "kino_enhancement_fabrication_machine",
    order = 51,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS.m_kino_fabricated_monster then

            local _targetSprite
            if card.ability.extra.level_non >= 1 then
                level1 = level1 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 0, y = 0})
                level1.role.draw_major = card
                level1:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
            end
            if card.ability.extra.level_non >= 2 then
                level2 = level2 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 1, y = 0})
                level2.role.draw_major = card
                level2:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                
                local speed = 10
                local formula = math.sin(speed * G.TIMERS.REAL) + math.cos(G.TIMERS.REAL)
                if formula >= 0 then
                    blinking_level2 = blinking_level2 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 1, y = 1})
                    blinking_level2.role.draw_major = card
                    blinking_level2:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                end
            end
            if card.ability.extra.level_non >= 3 then
                level3 = level3 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 2, y = 0})
                level3.role.draw_major = card
                level3:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
            
                -- Light 1
                local speed_1 = 12
                local formula_1 = math.sin(speed_1 * G.TIMERS.REAL) + math.cos(G.TIMERS.REAL)
                if formula_1 >= 0 then
                    blinking_level3_1 = blinking_level3_1 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 2, y = 1})
                    blinking_level3_1.role.draw_major = card
                    blinking_level3_1:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                end

                -- Light 2
                local speed_2 = 11
                local formula_2 = math.sin(speed_2 * (1.77 + G.TIMERS.REAL)) + math.cos((1.77 + G.TIMERS.REAL))
                if formula_2 >= 0 then
                    blinking_level3_2 = blinking_level3_2 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 2, y = 2})
                    blinking_level3_2.role.draw_major = card
                    blinking_level3_2:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                end
            
                -- Light 3
                local speed_3 = 5
                local formula_3 = math.sin(speed_3 * (0.8 + G.TIMERS.REAL)) + math.cos((0.8 + G.TIMERS.REAL))
                if formula_3 >= 0 then
                    blinking_level3_3 = blinking_level3_3 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancement_fabrication"], {x = 2, y = 3})
                    blinking_level3_3.role.draw_major = card
                    blinking_level3_3:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

-- The Pale Man

-- SMODS.Atlas {
--     key = "kinoween_pale_man",
--     atlas_table = "ANIMATION_ATLAS",
--     path = "kinoween_pale_man_blind.png",
--     px = 54,
--     py = 54,
--     frames = 21
-- }

SMODS.Atlas {
    key = "kinoween_pale_man",
    atlas_table = "ANIMATION_ATLAS",
    path = "kinoween_pale_man_blind_2.png",
    px = 34,
    py = 34,
    frames = 21
}

SMODS.Blind{
    key = "pale_man",
    dollars = 10,
    mult = 2,
    boss_colour = HEX('F0cdcd'),
    atlas = 'kinoween_pale_man', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    debuff = {

    },
    no_collection = true,
    in_pool = function(self)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end,
    loc_vars = function(self)
        local key
        if G.GAME.kinoween_fruit_eaten then
            key = self.key .. "_awoken"
        else
            key = self.key
        end
        return { key = key}
    end,
    collection_loc_vars = function(self)
        local key
        if G.GAME.kinoween_fruit_eaten then
            key = self.key .. "_awoken"
        else
            key = self.key
        end
        return { key = key}

    end,
    set_blind = function(self)
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)
        local _targets = {}
        for _index, _joker in ipairs(G.jokers.cards) do
            if _joker:get_total_multiplier(_joker) > 1 then
                _targets[#_targets + 1] = _joker
            end
        end

        if #_targets > 0 then
            local _target = pseudorandom_element(_targets, pseudoseed("kinoween_pale_man"))
            if _target and _target:can_calculate(_target) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_kino_blind_pale_man'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    self:wiggle()
                return true end }))
                
                SMODS.destroy_cards({_target})
                return true
            end
        end
    end,
    calculate = function(self, blind, context)

    end
}


-- None consumable
-- None
SMODS.Consumable {
    key = "fruit",
    set = "confection",
    order = 19,
    pos = {x = 4, y = 3},
    atlas = "kino_confections",
    no_collection = true,
    config = {
        choco_bonus = 0,
        extra = {
            active = false,
            times_used = 0,
        }
    },
    in_pool = function(self, args)
        -- Check for the right frequency
        if G.GAME.modifiers.kinoween and G.GAME.round_resets.blind_choices.Boss == "bl_kino_pale_man" then
            return true
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {
            
            vars = {
            }
        } 
    end,
    pull_button = true,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true or (card.area and card.area.config and card.area.config.type == 'shop') then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.config.card_limit)) then
                return true
            else
                return false
            end
                
        end

        return true
	end,
    keep_on_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if card.area ~= G.pack_cards and card.area ~= nil then
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            G.GAME.kinoween_fruit_eaten = true
            card.active = true

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true, 0.05)
        end
    end,
    calculate = function(self, card, context)

        if context.after and card.active then
            for _index, _joker in ipairs(G.jokers.cards) do
                Blockbuster.manipulate_value(_joker, "kinoween_fruit", 0.5, nil, true)
            end

            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}


-- Pennywise

SMODS.Atlas {
    key = "kinoween_pennywise",
    atlas_table = "ANIMATION_ATLAS",
    path = "kinoween_pennywise.png",
    px = 34,
    py = 34,
    frames = 69
}


SMODS.Blind{
    key = "pennywise",
    dollars = 10,
    mult = 2,
    boss_colour = HEX('c92828'),
    atlas = 'kinoween_pennywise', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    no_collection = true,
    debuff = {

    },
    in_pool = function(self)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end,
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)


    end,
    set_blind = function(self)
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "Enhanced", area = G.hand, key = "m_kino_pennywise_balloon", no_edition = true})
                _card:add_to_deck()
                G.hand:emplace(_card) 
                return true
            end}))
    end,
    calculate = function(self, blind, context)
        -- The top card of your deck is always a Balloon

        if context.pre_discard then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = SMODS.create_card({type = "Enhanced", area = G.hand, key = "m_kino_pennywise_balloon", no_edition = true})
                    _card:add_to_deck()
                    G.hand:emplace(_card) 
                    return true
                end}))
        end
    end
}

SMODS.Enhancement {
    key = "pennywise_balloon",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 2},
    no_collection = true,
    replace_base_card = true,
    overrides_base_rank = true,
    hidden = true,
    no_suit = true,
    always_scores = true,
    config = {
        extra = {

        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- While in your hand, destroy a random card each round. Can destroy itself
        if context.main_scoring and context.cardarea == G.hand then
            local _valid_targets = {}
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:can_calculate() then
                    _valid_targets[#_valid_targets + 1] = _pcard
                end
            end 

            if #_valid_targets > 0 then
                local _target = pseudorandom_element(_valid_targets, pseudoseed("kinoween_pennywise"))
                _target.marked_by_pennywise = true
            end
        end

        if context.destroy_card and context.cardarea == G.hand then

            if context.destroy_card.marked_by_pennywise then
                return { remove = true }
            end
            
        end
    end
}

local BalloonSprite
SMODS.DrawStep {
    key = "kino_enhancement_pennywise_balloon_step",
    order = 51,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS.m_kino_pennywise_balloon then
            local _xOffset = 0
            local _yOffset = 0
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            BalloonSprite = BalloonSprite or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancements"], {x = 1, y = 2})
            BalloonSprite.role.draw_major = card
            -- SuperheroSprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
            BalloonSprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
            BalloonSprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}


-- Jack Skellington

SMODS.Atlas {
    key = "kinoween_jack",
    atlas_table = "ANIMATION_ATLAS",
    path = "kinoween_jack.png",
    px = 34,
    py = 34,
    frames = 21
}



SMODS.Blind{
    key = "jack_skellington",
    dollars = 10,
    mult = 2,
    boss_colour = HEX('c38639'),
    atlas = 'kinoween_jack', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    no_collection = true,
    debuff = {

    },
    in_pool = function(self)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end,
    loc_vars = function(self)
        local key

        key = self.key

        return { key = key}
    end,
    collection_loc_vars = function(self)
        local key

        key = self.key

        return { key = key}
    end,
    set_blind = function(self)
        local list_of_spooky_objects = {
            "m_kino_horror",
            "m_kino_monster",
            "m_kino_crime",
            "m_kino_demonic",
            "m_kino_flying_monkey",
            "m_kino_pennywise_balloon",
            "m_kino_fabricated_monster",
            "m_kino_error",
            "m_kino_finance",
            "m_kino_factory",
            "m_kino_supervillain",
        }

        -- Wha-ah-ah-at's this, what's this
        -- Puts 3 Frost counters on every card and joker that isn't
        -- succificiently spooky
        for _index, _joker in ipairs(G.jokers.cards) do
            local _is_target = true
            if is_genre(_joker, "Horror") or is_genre(_joker, "Thriller") or is_genre(_joker, "Crime") then
                _is_target = false
            end

            if _is_target then
                _joker:bb_counter_apply("counter_frost", 3)
            end
        end

        for _index, _pcard in ipairs(G.playing_cards) do
            local _is_target = true
            for _index2, _enhancement in ipairs(list_of_spooky_objects) do
                if SMODS.has_enhancement(_pcard, _enhancement) then
                    _is_target = false
                    break
                end
            end

            if _is_target then
                _pcard:bb_counter_apply("counter_frost", 3)
            end
        end
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)

    end,
    calculate = function(self, blind, context)

    end
}

