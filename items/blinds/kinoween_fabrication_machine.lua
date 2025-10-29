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
    dollars = 5,
    mult = 2,
    boss_colour = HEX('90866d'),
    atlas = 'kinoween_fabrication_machine', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
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
