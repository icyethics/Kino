Blockbuster.Playset.Playsets = {}

---Object containing a list of joker packages
---@class Playset
---@field name string Name that is used when localization is missing
---@field types table[string] List of categories for categorization purposes
---@field packages table Dictionary keys for content_package objects that will be loaded in. True if loaded in, False if banned. Banned jokers always override
---@field sets table Dictionary of sets that will be affected. Can be set up, but can also be constructed on the fly
---@field mods? table Table with MOD IDs so object is only present if all mods exist
Blockbuster.Playset.Playset = SMODS.GameObject:extend {
    obj_table = Blockbuster.Playset.Playsets,
    obj_buffer = {},
    required_params = {
        'key',
        'packages'
    },
    set = 'Playset',
    process_loc_text = function(self)
        SMODS.process_loc_text(G.localization.misc.quips, self.key:lower(), self.loc_txt)
    end,
    name = 'None',
    types = {"Mechanical", "Aesthetic", "Balanced", "Broken"},
    packages = {
        all_vanilla_full = true,
    },
    mods = {
        "vanilla"
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
    register = function(self)
        if self.registered then
            sendWarnMessage(('Detected duplicate register call on Blockbuster.Playset.Playset %s'):format(self.key:lower()), self.set)
            return
        end
        if self:check_dependencies() then
            self.obj_buffer[#self.obj_buffer + 1] = self.key:lower()
            self.obj_table[self.key:lower()] = self
            self.registered = true
        end
    end,
    inject = function(self)
    end
}
