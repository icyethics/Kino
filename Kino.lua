Kino = {}
Kino.mod_dir = ''..SMODS.current_mod.path

kino_config = SMODS.current_mod.config

-- Kino = SMODS.current_mod
Kino.jokers = {}

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
}


-- Read in all the sprites
SMODS.Atlas {
    key = "kino_atlas_legendary",
    px = 71,
    py = 95,
    path =  'kino_jokers_legendary.png'
}

SMODS.Atlas {
    key = "kino_atlas_1",
    px = 71,
    py = 95,
    path =  '001_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_2",
    px = 71,
    py = 95,
    path =  '002_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_3",
    px = 71,
    py = 95,
    path =  '003_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_4",
    px = 71,
    py = 95,
    path =  '004_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_5",
    px = 71,
    py = 95,
    path =  '005_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_6",
    px = 71,
    py = 95,
    path =  '006_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_7",
    px = 71,
    py = 95,
    path =  '007_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_8",
    px = 71,
    py = 95,
    path =  '008_kino_jokerresprite.png'
}
SMODS.Atlas {
    key = "kino_atlas_9",
    px = 71,
    py = 95,
    path =  '009_kino_jokerresprite.png'
}

SMODS.Atlas {
    key = "kino_atlas_10",
    px = 71,
    py = 95,
    path =  '010_kino_jokerresprite.png'
}

SMODS.Atlas {
    key = "kino_exotic",
    px = 71,
    py = 95,
    path =  'kino_exotic.png'
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

SMODS.Atlas {
    key = "kino_ui",
    px = 40,
    py = 40,
    path = 'kino_ui_assets.png'
}

SMODS.Atlas {
    key = "kino_ui_large",
    px = 71,
    py = 95,
    path = 'kino_ui_assets_cardsized.png'
}

SMODS.Atlas {
    key = "kino_backs",
    px = 71,
    py = 95,
    path = 'kino_backs.png'
}

SMODS.Atlas {
    key = "kino_backs_genre",
    px = 71,
    py = 95,
    path = 'kino_genre_backs.png'
}

SMODS.Atlas {
    key = "kino_sleeves",
    px = 73,
    py = 95,
    path = 'kino_sleeves.png'
}

SMODS.Atlas {
    key = "kino_sleeves_genre",
    px = 73,
    py = 95,
    path = 'kino_genre_sleeves.png'
}

SMODS.Atlas {
    key = "kino_seg_display",
    px = 71,
    py = 95,
    path = 'kino_seg_display.png'
}

SMODS.Atlas {
    key = "kino_counters_jokers",
    px = 71,
    py = 95,
    path = 'kino_retrigger_info.png'
}

SMODS.Atlas {
    key = "kino_counters_pcards",
    px = 71,
    py = 95,
    path = 'kino_counters_pcards.png'
}

SMODS.Atlas {
    key = "kino_splash_screen",
    px = 409,
    py = 211,
    path = 'kino_splash_sprite.png'
}

-- Crossmod Atlases
SMODS.Atlas {
    key = "kino_cryptid_consumables",
    px = 71,
    py = 95,
    path = 'kino_cryptid.png'
}

SMODS.Atlas {
    key = "kino_morefluff_enhancements",
    px = 71,
    py = 95,
    path = 'kino_morefluff_enhancements.png'
}

SMODS.Atlas {
    key = "kino_mf_rotarots",
    px = 107,
    py = 107,
    path = 'kino_rotarot.png'
}

SMODS.Atlas {
    key = "kino_mf_time",
    px = 71,
    py = 71,
    path = 'kino_timecard_special_asset.png'
}

-- New file loading code

function Kino.load_file(file_address)
    local helper, load_error = SMODS.load_file(file_address)
    if load_error then
        sendDebugMessage ("The error is: "..load_error)
        else
        helper()
    end
end

local _list_of_files = {
    "src/KinoUI.lua",
    "card_ui.lua",
    "Kinofunctions.lua",
    "jokers.lua",
    "Kinogenres.lua",

    "movie_info.lua",
    -- "src/boss_blinds.lua",
    "src/abduction.lua",
    "src/codex_rework.lua",
    "src/counters.lua",
    "src/snack_bag.lua",
    "src/quest.lua",
    "src/malverk.lua",
    "src/per_card_rarity.lua",
    "src/powerchanges.lua",
    "src/create_card.lua",
    "src/start_run.lua",
    "src/cryptid.lua",
    "src/spritemanipulation.lua",
    "src/consumable_functions.lua",
    "src/jumpscare.lua",
    "src/run_info.lua",
    "src/spell_UI_popup.lua",
    "src/spellslinger_deck_UI.lua",

    -- Blockbuster loading
    "src/blockbuster.lua"
}

for _index, _filename in ipairs(_list_of_files) do
    Kino.load_file(_filename)
end

-- Load game objects
-- Register the Jokers
local _usedjokers = {}
local _options = {
    {kino_config.action_enhancement, action_objects},
    {kino_config.crime_enhancement, crime_objects},
    {kino_config.mystery_enhancement, mystery_objects},
    {kino_config.confection_mechanic, confection_object},
    {kino_config.vampire_jokers, vampire_objects},
    {kino_config.sci_fi_enhancement, sci_fi_objects},
    {kino_config.spellcasting, spellcasting_objects},
    {kino_config.demonic_enhancement, demonic_objects},
    {kino_config.horror_enhancement, horror_objects},
    {kino_config.romance_enhancement, romance_objects},
    {kino_config.jumpscare_mechanic, jumpscare_objects},
    {kino_config.time_based_jokers, timer_objects},
}

for _i, joker in ipairs(joker_list) do
    -- for each joker_list
    local _add = true
    for i = 1, #_options do
        -- if option is turned off
        if not _options[i][1] then
            for _j, joker_banned in ipairs(_options[i][2].jokers) do
                if joker == joker_banned then
                    _add = false
                end
            end
        end
    end

    if _add then
        _usedjokers[#_usedjokers + 1] = joker
    end
end

-- NEW JOKER LOADING --
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Jokers")
for _, joker in ipairs(_usedjokers) do
    assert(SMODS.load_file("Items/Jokers/" .. joker .. ".lua"))()
    Kino.jokers[#Kino.jokers + 1] = "j_kino_" .. joker
end

-- Register the Enhancements
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Enhancements")
for _, file in ipairs(files) do
    local _add = true
    for i = 1, #_options do
        -- if option is turned off
        if not _options[i][1] then
            for _j, enhancement_banned in ipairs(_options[i][2].enhancements) do
                if file == (enhancement_banned .. ".lua") then
                    _add = false   
                end
            end
        end
    end
    if _add then
        assert(SMODS.load_file("Items/Enhancements/" .. file))()
    end
end

-- Register the Card Blinds
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Blinds")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Blinds/" .. file))()
end

-- Register the Backs
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Backs")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Backs/" .. file))()
end

-- Register the Sleeves
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Sleeve")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Sleeve/" .. file))()
end

-- Register the Consumable Types
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Consumable_types")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumable_types/" .. file))()
end

-- Register the Counters
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Counters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Counters/" .. file))()
end


-- Register the Consumables
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Consumables")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Consumables/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Boosters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Boosters/" .. file))()
end

-- Register the Vouchers
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Vouchers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Vouchers/" .. file))()
end

-- Register the Seals
local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Seals")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Seals/" .. file))()
end

local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Stickers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Stickers/" .. file))()
end

local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Tags")
for _, file in ipairs(files) do
    assert(SMODS.load_file("Items/Tags/" .. file))()
end

if kino_config.spellcasting then
    local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Spells")
    for _, file in ipairs(files) do
        assert(SMODS.load_file("Items/Spells/" .. file))()
    end
end

if kino_config.spellcasting then
    local files = NFS.getDirectoryItems(Kino.mod_dir .. "Items/Challenges")
    for _, file in ipairs(files) do
        assert(SMODS.load_file("Items/Challenges/" .. file))()
    end
end

kino_genre_init()
Kino.metadata()

SMODS.ObjectType {
    key = "kino_batman",
    default = "j_kino_batman_1989",
    rarities = {
        { key = "Common" },
        { key = "Uncommon" },
        { key = "Rare" },
    }
}

SMODS.ObjectType {
    key = "kino_starwars",
    default = "j_kino_star_wars_i",
    rarities = {
        { key = "Common" },
        { key = "Uncommon" },
        { key = "Rare" },
    }
}

