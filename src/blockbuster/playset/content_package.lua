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
        if not Blockbuster.content_package_area or
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
    
}
