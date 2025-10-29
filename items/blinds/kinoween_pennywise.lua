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
    dollars = 5,
    mult = 2,
    boss_colour = HEX('c92828'),
    atlas = 'kinoween_pennywise', 
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
