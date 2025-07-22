SMODS.Enhancement {
    key = "superhero",
    atlas = "kino_enhancements",
    pos = { x = 5, y = 5},
    config = {
        given_x_mult = 1,
        a_xmult = 0.5
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.a_xmult,
                card.ability.given_x_mult + (G.GAME.current_round.hands_played * card.ability.a_xmult)
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- Gives X0.5 mult for each hand used
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = card.ability.given_x_mult + (G.GAME.current_round.hands_played * card.ability.a_xmult)
            }
        end
    end
}

local SuperheroSprite
SMODS.DrawStep {
    key = "kino_enhancement_superhero_step",
    order = 51,
    func = function(card, layer)
        if card and SMODS.has_enhancement(card, 'm_kino_superhero') then
            local _xOffset = 0
            local _yOffset = 0
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            SuperheroSprite = SuperheroSprite or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancements"], {x = 1, y = 1})
            SuperheroSprite.role.draw_major = card
            -- SuperheroSprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
            SuperheroSprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
            SuperheroSprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}
