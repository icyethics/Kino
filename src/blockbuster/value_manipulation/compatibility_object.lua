Blockbuster.ValueManipulation.CompatStandards = {}
Blockbuster.ValueManipulation.ModToCompatStandard = {}

---Object containing information on how to process variables to manipulate their values
---@class CompatStandard
---@field variable_conventions? table[full_vars: table, ends_on: table, starts_with: table] Table containing naming conventions to mark for exclusion for Value Manipulation
---@field integer_only_variable_conventions? table[full_vars: table, ends_on: table, starts_with: table] naming conventions for values that should only be changed into integers
---@field variable_caps? table Dictionary with variables and associated maximum values
---@field min_max_values? table[min: num, max: num] Minimum and Maximum total value multiplication that standards allows for
---@field exempt_jokers? table Dictionary of keys of objects to make incompatible with value manipulation
---@field redirect_objects? table[key: table] Dictionary of redirection paths, indicating which joker to redirect to which standard
---@field source_mod? string Key matching Source Mod ID to set as default
Blockbuster.ValueManipulation.CompatStandard = SMODS.GameObject:extend {
    obj_table = Blockbuster.ValueManipulation.CompatStandards,
    obj_buffer = {},
    required_params = {
        'key'
    },
    set = 'CompatStandards',
    process_loc_text = function(self)
        SMODS.process_loc_text(G.localization.misc.quips, self.key:lower(), self.loc_txt)
    end,
    variable_conventions = {
        full_vars = {},
        ends_on = {},
        starts_with = {},
    },
    integer_only_variable_conventions = {
        full_vars = {},
        ends_on = {},
        starts_with = {},
    },
    variable_caps = {
        -- variable_key = 10 (the cap)
    },
    min_max_values = {min = 0, max = 25}, -- Min will be assumed to be 0 (to prevent negative values.) Max is equal to 25 by default
    exempt_jokers = nil,
    redirect_objects = nil, -- You can store a table here with jokers you want to have another standard for
    source_mod = nil,
    register = function(self)
        if self.registered then
            sendWarnMessage(('Detected duplicate register call on Blockbuster.ValueManipulation.CompatStandard %s'):format(self.key:lower()), self.set)
            return
        end
        if self:check_dependencies() then
            self.obj_buffer[#self.obj_buffer + 1] = self.key:lower()
            self.obj_table[self.key:lower()] = self
            self.registered = true
        end
    end,
    inject = function(self)
        self.extra = self.extra or {center = 'j_joker'}
        if self.source_mod then
            Blockbuster.RegisterCompatStandardWithMod(self.key:lower(), self.source_mod)
        end
        
    end
}


---Registers the Standard to be the default for a Specific mod
---@param key_to_standard string
---@param mod_id string
Blockbuster.RegisterCompatStandardWithMod = function(key_to_standard, mod_id)
    Blockbuster.ValueManipulation.ModToCompatStandard[mod_id] = key_to_standard
end

