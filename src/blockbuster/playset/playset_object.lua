Blockbuster.Playset.Playsets = {}

---Object containing a list of joker packages
---@class Playset
---@field name string Name that is used when localization is missing
---@field types table[string] List of categories for categorization purposes
---@field packages table Dictionary keys for content_package objects that will be loaded in. True if loaded in, False if banned. Banned jokers always override
---@field sets table Dictionary of sets that will be affected. Can be set up, but can also be constructed on the fly
---@field mods? table Table with MOD IDs so object is only present if all mods exist
Blockbuster.Playset.Playset = SMODS.Center:extend {
    obj_table = Blockbuster.Playset.Playsets,
    obj_buffer = {},
    required_params = {
        'key',
        'packages'
    },
    set = 'Playset',
    process_loc_text = function(self)
        if not G.localization.descriptions.Playset then
            G.localization.descriptions.Playset = {}
        end
        SMODS.process_loc_text(G.localization.descriptions.Playset, self.key:lower(), self.loc_txt)
    end,
    name = 'None',
    types = {"Mechanical", "Aesthetic", "Balanced", "Broken"},
    packages = {
        all_vanilla_full = true,
    },
    mods = {
        "vanilla"
    },
    order = 0,
    config = {

    },
    sets = {
        -- Enhanced = true,
        -- Edition = true,
        -- Joker = true,
        -- Planet = true,
        -- Tarot = true,
        -- Spectral = true,
        -- Voucher = true,
        -- Booster = true
    },
    displayImage = "j_joker",
    register = function(self)
        if self.registered then
            sendWarnMessage(('Detected duplicate register call on Blockbuster.Playset.Playset %s'):format(self.key:lower()), self.set)
            return
        end
        if self:check_dependencies() then
            self.obj_buffer[#self.obj_buffer + 1] = self.key:lower()
            self.obj_table[self.key:lower()] = self
            self.registered = true
            self:process_loc_text(self)
        end
    end,
    set_sprites = function(self, card, front)
        if self.displayImage or true then
            local _sourceObject = G.P_CENTERS[self.displayImage]
            if not _sourceObject then
                -- print("MISSING " .. self.displayImage)
                -- return
                _sourceObject = G.P_CENTERS.j_joker
            end

            local _atlas 
            if _sourceObject.atlas then
                card.children.center.atlas.name = _sourceObject.atlas
            else 
                card.children.center.atlas.name = (_sourceObject.atlas or (_sourceObject.set == 'Joker' or _sourceObject.consumeable or _sourceObject.set == 'Voucher') and _sourceObject.set) or 'centers'
            end
            
            card.children.center.sprite_pos = _sourceObject.pos
            card.children.center:reset()
        end
    end,
    inject = function(self)
    end,
    get_name = function(self)
        -- print(G.localization.descriptions.Playset[self.key])
        return G.localization.descriptions.Playset[self.key].name
    end
}


local playset_Frame
SMODS.DrawStep {
    key = "bbplayset_playset_layer",
    order = 51,
    func = function(card, layer)
        -- if card and card.config.center == G.P_CENTERS.m_kino_superhero then
        if card and card.config and card.config.center and card.config.center.set == "Playset" then
            playset_Frame = playset_Frame or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_bbplayset_playset_frame"], {x = 0, y = 0})
            playset_Frame.role.draw_major = card

            playset_Frame:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}