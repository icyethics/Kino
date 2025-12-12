-- Collection Filter

SMODS.DrawStep {
    key = 'blockbuster_banned_content',
    order = 70,
    func = function(self)
        if self.area and self.area.config.collection and self.config.center then
            if G.GAME.banned_keys[self.config.center.key] then
                self.children.center:draw_shader('debuff', nil, self.ARGS.send_to_shader)
                if self.children.front and (self.ability.delayed or not self:should_hide_front()) then
                    self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

local _initialRun = true
-- Code taken from TOGA's Stuff
Blockbuster.updatecollectionitems = function()
	for _, t in ipairs{G.P_CENTERS, G.P_TAGS, G.P_SEALS} do
		for k, v in pairs(t) do
            if _initialRun and v.no_collection then
                v.no_collection_restore = true
            end

            if G.GAME.banned_keys[v.key] then
                if v.no_collection and v.no_collection == true then
                    v.no_collection = true
                else
                    v.no_collection = true
                end
            else
                if v.no_collection_restore and v.no_collection_restore == true then
                    v.no_collection = true
                else
                    v.no_collection = false
                end
            end
		end
	end

    _initialRun = false
end

-- hook for the overlay menu
local o_overlay_menu = G.FUNCS.overlay_menu
G.FUNCS.overlay_menu = function(args)
    local _ret = o_overlay_menu(args)
    Blockbuster.updatecollectionitems()
    return _ret
end