mod_dir = ''..SMODS.current_mod.path

-- Kino_config = SMODS.current_mod.config
-- Kino.enabled = copy_table(Kino_config)

Kino = SMODS.current_mod
Kino.jokers = {}

Kino.optional_features = function()
    return {
        retrigger_joker = true,
        cardareas = {unscored = true}
    }
end

optional_features = function()
    return {
        retrigger_joker = true,
        cardareas = {unscored = true}
    }
end

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
    key = "kino_atlas_4",
    px = 71,
    py = 95,
    path =  'kino_jokers_4.png'
}
SMODS.Atlas {
    key = "kino_atlas_5",
    px = 71,
    py = 95,
    path =  'kino_jokers_5.png'
}
SMODS.Atlas {
    key = "kino_atlas_6",
    px = 71,
    py = 95,
    path =  'kino_jokers_6.png'
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

SMODS.Atlas {
    key = 'kino_boosters',
    px = 71,
    py = 95,
    path = 'kino_boosters.png'
}

SMODS.Atlas {
    key = 'kino_confections',
    px = 71,
    py = 95,
    path = 'kino_confections.png'
}

SMODS.Atlas {
    key = "kino_tags",
    px = 34,
    py = 34,
    path = 'kino_tags.png'
}

SMODS.Atlas {
    key = "kino_vouchers",
    px = 71,
    py = 95,
    path =  'kino_vouchers.png'
}

SMODS.Atlas {
    key = "kino_stickers",
    px = 71,
    py = 95,
    path = 'kino_stickers.png'
}

SMODS.Atlas {
    key = "kino_spells",
    px = 71,
    py = 95,
    path = 'kino_spells.png'
}


-- Load additional files
local helper, load_error = SMODS.load_file("Kinofunctions.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

function is_genre(joker, genre)
    if joker.config.center.k_genre then
        for i = 1, #joker.config.center.k_genre do
            if genre == joker.config.center.k_genre[i] then
                return true
            end
        end
    end
    return false
end

-- Add Kino mod specific game long globals
-- Scrap total
-- Matches Made
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.current_round.scrap_total = 0
    ret.current_round.matches_made = 0
    ret.current_round.sci_fi_upgrades = 0
    ret.current_round.sci_fi_upgrades_last_round = 0
    ret.current_round.sacrifices_made = 0
    ret.current_round.kryptons_used = 0
    ret.current_round.beaten_run_high = 0
    ret.current_round.horror_transform = 0
    ret.genre_synergy_treshold = 5
    
    ret.spells_cast = 0
    ret.confections_used = 0
    -- generate_cmifc_rank()
    return ret
end

-- Register the Jokers
local files = NFS.getDirectoryItems(mod_dir .. "Items/Jokers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Jokers/" .. file))()

    local string = string.sub(file, 1, #file-4)
    Kino.jokers[#Kino.jokers + 1] = "j_kino_" .. string

end

-- Register the Enhancements
local files = NFS.getDirectoryItems(mod_dir .. "Items/Enhancements")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Enhancements/" .. file))()
end

-- Register the Consumable Types
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumable_types")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumable_types/" .. file))()
end


-- Register the Consumables
local files = NFS.getDirectoryItems(mod_dir .. "Items/Consumables")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumables/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(mod_dir .. "Items/Boosters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Boosters/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(mod_dir .. "Items/Vouchers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Vouchers/" .. file))()
end

local files = NFS.getDirectoryItems(mod_dir .. "Items/Stickers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Stickers/" .. file))()
end

local files = NFS.getDirectoryItems(mod_dir .. "Items/Spells")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Spells/" .. file))()
end

-- Register the genres
local helper, load_error = SMODS.load_file("Kinogenres.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("movie_info.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("KinoUI.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

kino_genre_init()


--
SMODS.Keybind{
	key = 'start_synergy_check',
	key_pressed = 'a',
    held_keys = {'rctrl'}, -- other key(s) that need to be held

    action = function(self)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:kino_synergy(G.jokers.cards[i])
        end
    end,
}

SMODS.Keybind{
	key = 'start_genre_check',
	key_pressed = 's',
    held_keys = {'rctrl'}, -- other key(s) that need to be held

    action = function(self)
        check_genre_synergy()
    end,
}

