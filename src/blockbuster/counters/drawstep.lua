-- UISprites draw a canvas instead of sprite atlas
UISprite = Sprite:extend()

function UISprite:draw_from(other_obj, canvas, ms, mr, mx, my)
    self.ARGS.draw_from_offset = self.ARGS.draw_from_offset or {}
    self.ARGS.draw_from_offset.x = mx or 0
    self.ARGS.draw_from_offset.y = my or 0
    prep_draw(other_obj, (1 + (ms or 0)), (mr or 0), self.ARGS.draw_from_offset, true)
    love.graphics.scale(1/(other_obj.scale_mag or other_obj.VT.scale))
    love.graphics.setColor(G.BRUTE_OVERLAY or G.C.WHITE)
    love.graphics.draw(
        canvas,
        self.sprite,
        -(other_obj.T.w/2 -other_obj.VT.w/2)*10,
        0,
        0,
        other_obj.VT.w/(other_obj.T.w),
        other_obj.VT.h/(other_obj.T.h)
    )
    self:draw_boundingrect()
    love.graphics.pop()
end

function UISprite:draw_shader(other_obj, canvas, _no_tilt)
    if G.SETTINGS.reduced_motion then _no_tilt = true end
    local _draw_major = self.role.draw_major or self

    self.ARGS.prep_shader = self.ARGS.prep_shader or {}
    self.ARGS.prep_shader.cursor_pos = self.ARGS.prep_shader.cursor_pos or {}
    self.ARGS.prep_shader.cursor_pos[1] = _draw_major.tilt_var and _draw_major.tilt_var.mx*G.CANV_SCALE or G.CONTROLLER.cursor_position.x*G.CANV_SCALE
    self.ARGS.prep_shader.cursor_pos[2] = _draw_major.tilt_var and _draw_major.tilt_var.my*G.CANV_SCALE or G.CONTROLLER.cursor_position.y*G.CANV_SCALE

    G.SHADERS['dissolve']:send('mouse_screen_pos', self.ARGS.prep_shader.cursor_pos)
    G.SHADERS['dissolve']:send('screen_scale', G.TILESCALE*G.TILESIZE*(_draw_major.mouse_damping or 1)*G.CANV_SCALE)
    G.SHADERS['dissolve']:send('hovering',((_shadow_height  and not tilt_shadow) or _no_tilt) and 0 or (_draw_major.hover_tilt or 0)*(tilt_shadow or 1))
    G.SHADERS['dissolve']:send("dissolve",math.abs(_draw_major.dissolve or 0))
    G.SHADERS['dissolve']:send("time",123.33412*(_draw_major.ID/1.14212 or 12.5123152)%3000)
    G.SHADERS['dissolve']:send("texture_details",self:get_pos_pixel())
    G.SHADERS['dissolve']:send("image_details",self:get_image_dims())
    G.SHADERS['dissolve']:send("burn_colour_1",_draw_major.dissolve_colours and _draw_major.dissolve_colours[1] or G.C.CLEAR)
    G.SHADERS['dissolve']:send("burn_colour_2",_draw_major.dissolve_colours and _draw_major.dissolve_colours[2] or G.C.CLEAR)
    G.SHADERS['dissolve']:send("shadow",(not not _shadow_height))

    local p_shader = SMODS.Shader.obj_table['dissolve']
    if p_shader and type(p_shader.send_vars) == "function" then
        local sh = G.SHADERS[_shader or 'dissolve']
        local parent_card = self.role.major and self.role.major:is(Card) and self.role.major
        local send_vars = p_shader.send_vars(self, parent_card)
    
        if type(send_vars) == "table" then
            for key, value in pairs(send_vars) do
                sh:send(key, value)
            end
        end
    end

    love.graphics.setShader( G.SHADERS['dissolve'],  G.SHADERS['dissolve'])
    self:draw_from(other_obj, canvas)
    love.graphics.setShader()
end

-- the canvas
local canvas = love.graphics.newCanvas(1920, 1080)
canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)

SMODS.DrawStep {
    key = "counters_joker",
    order = 71,
    func = function(card, layer)
        if card and card.counter_config and
        card.counter_config.counter_num_ui > 0 and 
        (card.ability.set ~= 'Default' and card.ability.set ~='Enhanced')  then

            -- Sprite
            G["shared_counters_joker"][card.counter_config.counter_key_ui].role.draw_major = card
            G["shared_counters_joker"][card.counter_config.counter_key_ui]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            
            love.graphics.push()
            love.graphics.origin()
            canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
            love.graphics.setColor(1, 1, 1)
            canvas:renderTo(love.graphics.print, "+" .. card.counter_config.counter_num_ui, 25, 25, 0, 1.5)
            love.graphics.pop()

            G["shared_counters_ui"][card.counter_config.counter_key_ui].role.draw_major = card
            G["shared_counters_ui"][card.counter_config.counter_key_ui]:draw_shader(card.children.center, canvas)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

SMODS.DrawStep {
    key = "counters_pcard",
    order = 71,
    func = function(card, layer)
        if card and card.counter_config and 
        card.counter_config.counter_num_ui > 0 and 
        (card.ability.set == 'Default' or card.ability.set =='Enhanced')  then
            G["shared_counters_pcard"][card.counter_config.counter_key_ui].role.draw_major = card
            G["shared_counters_pcard"][card.counter_config.counter_key_ui]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        
            love.graphics.push()
            love.graphics.origin()
            canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
            love.graphics.setColor(1, 1, 1)
            canvas:renderTo(love.graphics.print, "+" .. card.counter_config.counter_num_ui, 25, 215, 0, 1.5)
            love.graphics.pop()

            G["shared_counters_ui"][card.counter_config.counter_key_ui].role.draw_major = card
            G["shared_counters_ui"][card.counter_config.counter_key_ui]:draw_shader(card.children.center, canvas)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

SMODS.DrawStep {
    key = "counters_back",
    order = 71,
    func = function(card, layer)
        if card and card.counter_config and
        card.counter_config.counter_num_ui > 0 then

            if card.children and card.children.counter_ui_box then
                card.children.counter_ui_box.states.visible = false
            end
        end
    end,
    conditions = {vortex = false, facing = 'back'}
}
