mod_dir = ''..SMODS.current_mod.path

-- Kino_config = SMODS.current_mod.config
-- Kino.enabled = copy_table(Kino_config)

-- Read in all the sprites
SMODS.Atlas {
    key = "kino_atlas_1",
    px = 71,
    py = 95,
    path =  'kino_jokers_1.png'
}
SMODS.Atlas {
    key = "kino_atlas_2",
    px = 71,
    py = 95,
    path =  'kino_jokers_2.png'
}
SMODS.Atlas {
    key = "kino_atlas_3",
    px = 71,
    py = 95,
    path =  'kino_jokers_3.png'
}

SMODS.Atlas {
    key = 'modicon',
    px = 32,
    py = 32,
    path = 'modicon.png'
}

SMODS.Atlas {
    key = 'kino_tarot',
    px = 71,
    py = 95,
    path = 'kino_tarot.png'
}

SMODS.Atlas {
    key = 'kino_enhancements',
    px = 71,
    py = 95,
    path = 'kino_enhancements.png'
}

-- DO NOT DISTRIBUTE WITH THIS IN HERE
local helper, load_error = SMODS.load_file("/docs/createjokerfiles_ds.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end


-- Load additional files
local helper, load_error = SMODS.load_file("Kinofunctions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end

-- Add Mult Bonus (Code adapted from AutumnMood (https://github.com/AutumnMood924/AutumnMoodMechanics/blob/main/amm.lua))
local alias__Card_get_chip_mult = Card.get_chip_mult;
function Card:get_chip_mult()
    if self.debuff then return 0 end
    local ret = alias__Card_get_chip_mult(self) + (self.ability.perma_mult or 0)
	return ret
end

function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other["card_extra_mult"] = {
		text = {
			"{C:mult}+#1#{} extra Mult"
		}
	}
end
-- End of adapted code

-- Add Kino mod specific game long globals
-- Scrap total
-- Matches Made
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.current_round.scrap_total = 0
    ret.current_round.matches_made = 0
    ret.current_round.sci_fi_upgrades = 0
    return ret
end

-- Register the Jokers
local files = NFS.getDirectoryItems(mod_dir .. "Items/Jokers")
for _, file in ipairs(files) do
    print("Loading file: " .. file)
    local status, err = pcall(function()
        return NFS.load(mod_dir .. "/Items/Jokers/" .. file)()
    end)
    sendDebugMessage("Loaded Joker: " .. file, "--KINO")

    if not status then
        error(file .. ": " .. err)
    end
end

-- Register the Enhancements
local files = NFS.getDirectoryItems(mod_dir .. "Items/Enhancements")
for _, file in ipairs(files) do
    print("Loading file: " .. file)
    local status, err = pcall(function()
        return NFS.load(mod_dir .. "/Items/Enhancements/" .. file)()
    end)
    sendDebugMessage("Loaded Enhancement: " .. file, "--KINO")

    if not status then
        error(file .. ": " .. err)
    end
end

-- Register the Consumables
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumable")
for _, file in ipairs(files) do
    print("Loading file: " .. file)
    local status, err = pcall(function()
        return NFS.load(mod_dir .. "Items/Consumable/" .. file)()
    end)
    sendDebugMessage("Loaded Consumable: " .. file, "--KINO")

    if not status then
        error(file .. ": " .. err)
    end
end