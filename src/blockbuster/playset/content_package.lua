Blockbuster.Playset.ContentPackages = {}

---Object containing a list of joker packages
---@class ContentPackage
---@field name string Name that is used when localization is missing
---@field types table[string] List of categories for categorization purposes
---@field displayImage string Key of the card that will be used to refer to this package visually
---@field items table Dictionary keys for content_package objects that will be loaded in. True if loaded in, False if banned. Banned jokers always override
---@field domains table List of categories that match with sets of objects, so the playset does not ban all content from sets it does not concern itself with (such as boss blinds, or vouchers, for example)
---@field mods? table Table with MOD IDs so object is only present if all mods exist
Blockbuster.Playset.ContentPackage = SMODS.Center:extend {
    obj_table = Blockbuster.Playset.ContentPackages,
    obj_buffer = {},
    required_params = {
        'key',
    },
    set = 'ContentPackage',
    process_loc_text = function(self)
        if not G.localization.descriptions.ContentPackage then
            G.localization.descriptions.ContentPackage = {}
        end
        SMODS.process_loc_text(G.localization.descriptions.ContentPackage, self.key, self.loc_txt)
    end,
    name = 'None',
    types = {"Mechanical", "Aesthetic", "Balanced", "Broken", "Vanilla-Only", "Modded-Only"},
    
    -- Visuals
    displayImage = "j_joker",
    atlas = "Joker",
    pos = {x = 0, y = 0},
    order = 0,
    config = {

    },

    items = {
        j_joker = true,
    },
    mods = {
        "vanilla"
    },
    sets = {
        'Joker'
    },
    register = function(self)
        if self.registered then
            sendWarnMessage(('Detected duplicate register call on Blockbuster.Playset.ContentPackage %s'):format(self.key:lower()), self.set)
            return
        end
        if self:check_dependencies() then
            self.obj_buffer[#self.obj_buffer + 1] = self.key:lower()
            self.obj_table[self.key:lower()] = self
            self.registered = true
            self:process_loc_text(self)
        end
    end,
    click = function(self)
        play_sound('button', 1, 0.3)
        if self.during_galdur then 
            self:juice_up()
            local _key = self.config.center.key
            Blockbuster.Playset.startup.contentPackages = Blockbuster.Playset.startup.contentPackages or {}
            if Blockbuster.Playset.startup.contentPackages[_key] then
                if Blockbuster.Playset.startup.contentPackages[_key] == "Ban" then
                    Blockbuster.Playset.startup.contentPackages[_key] = "Include"
                else
                    Blockbuster.Playset.startup.contentPackages[_key] = nil
                end
            else
                Blockbuster.Playset.startup.contentPackages[_key] = "Ban"
            end
        elseif not Blockbuster.content_package_area or
        (Blockbuster.content_package_area and (self.area ~= Blockbuster.content_package_area)) then
            G.SETTINGS.paused = true
            G.FUNCS.overlay_menu{
                definition = Blockbuster.Playset.create_content_showcase(self),
            }
        end
    end,
    set_sprites = function(self, card, front)
        if self.displayImage then
            local _sourceObject = G.P_CENTERS[self.displayImage]
            if not _sourceObject then
                print("MISSING " .. self.displayImage)
                return
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
    get_name = function()
        return self.loc_name
    end
    
}

local contentPackage
local inclusionSpriteGood
local inclusionSpriteBad
SMODS.DrawStep {
    key = "bbplayset_contentPackage_layer",
    order = 51,
    func = function(card, layer)
        -- if card and card.config.center == G.P_CENTERS.m_kino_superhero then
        if card and card.config and card.config.center and card.config.center.set == "ContentPackage" then
            contentPackage = contentPackage or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_bbplayset_content_pack_frame"], {x = 0, y = 0})
            contentPackage.role.draw_major = card

            contentPackage:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
            if (Blockbuster.Playset and 
            Blockbuster.Playset.startup and 
            Blockbuster.Playset.startup.contentPackages and
            Blockbuster.Playset.startup.contentPackages[card.config.center.key])
            or (Blockbuster.Playset and 
            Blockbuster.Playset.startup and 
            Blockbuster.Playset.startup.choices and
            Blockbuster.Playset.startup.choices.playset) then

                local _state = nil
                if Blockbuster.Playset.startup.contentPackages and Blockbuster.Playset.startup.contentPackages[card.config.center.key] == "Ban" then
                    _state = "Ban"
                elseif Blockbuster.Playset.startup.contentPackages and Blockbuster.Playset.startup.contentPackages[card.config.center.key] == "Include" then
                    _state = "Include"
                elseif Blockbuster.Playset.startup.choices.playset.packages[card.config.center.key] == true then
                    _state = "Include"
                elseif Blockbuster.Playset.startup.choices.playset.packages[card.config.center.key] == false then
                    _state = "Ban"
                    
                end

                if _state == "Ban" then
                    inclusionSpriteBad = inclusionSpriteBad or Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=1, y=1})
                    inclusionSpriteBad.role.draw_major = card
                    inclusionSpriteBad:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                elseif _state == "Include" then
                    inclusionSpriteGood = inclusionSpriteGood or Sprite(0,0,0.5,0.5, G.ASSET_ATLAS["kino_ui"], {x=2, y=1})
                    inclusionSpriteGood.role.draw_major = card
                    inclusionSpriteGood:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, nil)
                end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}