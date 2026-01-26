SMODS.Consumable({
    object_type = "Consumable",
    set = "Unique",
    key = "bullets",
    pos = { x = 0, y = 0 },
    config = {
        max_highlighted = 1,
        extra_slots_used = -1
    },
    cost = 0,
    atlas = "kino_bullets",
    unlocked = true,
    discovered = false,
    can_be_sold = false,
    keep_on_use = function(self, card)
        return true
    end,
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                G.GAME.bullet_count
            } 
        }
    end,
    kino_is_bullets = true,
    set_ability = function(self, card, initial, delay_sprites)
        SMODS.Stickers['eternal']:apply(card)
    end,
    use = function(self, card, area, copier)
        local _target
        if #G.jokers.highlighted == 1 and #G.hand.highlighted == 0 then
            if G.jokers.highlighted[1].config.center.kino_bullet_compat then
                _target = G.jokers.highlighted[1]
                _target:bb_counter_apply("counter_kino_bullet_joker", 1)
                Kino:use_bullets(1)
            end
        elseif #G.jokers.highlighted == 0 and #G.hand.highlighted == 1 then
            _target = G.hand.highlighted[1]
            _target:bb_counter_apply("counter_kino_bullet_pcard", 1)
            Kino:use_bullets(1)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.bullet_buffer = nil
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.bullet_buffer = nil
    end,
    can_use = function(self, card)

        if #G.jokers.highlighted == 1 and #G.hand.highlighted == 0 then
            if G.jokers.highlighted[1].config.center.kino_bullet_compat then
                return true
            end
        elseif #G.jokers.highlighted == 0 and #G.hand.highlighted == 1 then
            return true
        end

		return false
	end,
})


function Kino:add_bullet(number)
    G.GAME.bullet_count = math.min((G.GAME.bullet_count + (number or 1)), Kino.bullet_magazine_max)
    G.GAME.bullets_obtained = G.GAME.bullets_obtained and G.GAME.bullets_obtained + number or number
    inc_career_stat("kino_bullets_obtained", number)

    local _bullets_exist = false
    for i, _consumeable in ipairs(G.consumeables.cards) do
        if _consumeable.config.center.kino_is_bullets then
            _bullets_exist = true
            break
        end
    end

    if not G.GAME.bullet_buffer and
    _bullets_exist == false then
        G.GAME.bullet_buffer = true
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "Unique", area = G.consumeables, key = "c_kino_bullets", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                G.GAME.bullet_buffer = nil
                return true
        end}))
    end
end

function Kino:use_bullets(number)
    local _num = number or 1
    G.GAME.bullet_count = math.max((G.GAME.bullet_count - _num), 0)
    G.GAME.bullets_loaded = G.GAME.bullets_loaded and G.GAME.bullets_loaded + number or number
    inc_career_stat("kino_bullets_loaded", number)
    check_for_unlock({type = 'load_bullet'})

    if G.GAME.bullet_count <= 0 then
        for i, _consumeable in ipairs(G.consumeables.cards) do
            if _consumeable.config.center.kino_is_bullets then
                _consumeable:start_dissolve()
            end
        end
    end
end

-- -- the canvas
local canvas = love.graphics.newCanvas(1920, 1080)
canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)


-- local bulletSprite1
-- local bulletSprite2
-- local bulletSprite3
-- local bullet_ui
SMODS.DrawStep {
    key = "kino_bullet",
    order = 51,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS.c_kino_bullets then
            local _xOffset = 0
            local _yOffset = 0
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            -- local drawnSprite = bulletSprite1 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_bullets"], {x = 1, y = 0})
            local drawnSprite = G.kino_bullets_ui.BulletSprite_1
            if G.GAME.bullet_count > 5 and G.GAME.bullet_count < 15 then
                drawnSprite = G.kino_bullets_ui.BulletSprite_2
                -- drawnSprite = bulletSprite2 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_bullets"], {x = 0, y = 1})
            elseif G.GAME.bullet_count >= 15 then
                drawnSprite = G.kino_bullets_ui.BulletSprite_3
                -- drawnSprite = bulletSprite3 or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_bullets"], {x = 1, y = 1})
            end

            
            drawnSprite.role.draw_major = card
            drawnSprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
            drawnSprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)

            -- Text rendering
            love.graphics.push()
            love.graphics.origin()
            canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
            love.graphics.setColor(1, 1, 1)
            canvas:renderTo(love.graphics.print, "X" .. tostring(G.GAME.bullet_count), 700, 370, 0, 8)
            love.graphics.pop()

            -- bullet_ui = bullet_ui or UISprite(0, 0, G.CARD_W, G.CARD_H,
            -- G.ASSET_ATLAS["kino_bullets"], { x = 0, y = 0 })
            -- bullet_ui.role.draw_major = card
            -- bullet_ui:draw_shader(card.children.center, canvas)
            G.kino_bullets_ui.BulletUISprite.role.draw_major = card
            G.kino_bullets_ui.BulletUISprite:draw_shader(card.children.center, canvas)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}