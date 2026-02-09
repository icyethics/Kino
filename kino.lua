Kino = {}
Kino.mod_dir = ''..SMODS.current_mod.path

kino_config = SMODS.current_mod.config

-- Kino = SMODS.current_mod
Kino.jokers = {}

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
}

local _jokeratlas_count = 11

for _index = 1, _jokeratlas_count do
    local _numprefix = _index < 10 and "00" or "0"

    SMODS.Atlas {
        key = "kino_atlas_" .. _index,
        px = 71,
        py = 95,
        path = _numprefix .. _index .. "_kino_jokerresprite.png"
    }
end

local non_jokeratlases = 
{
    {"modicon", 32, 32, "modicon.png"},
    {"kino_counters", 73, 97, "kino_counters.png"},
    {"kino_tarot", 71, 95, "kino_tarot.png"},
    {"kino_enhancements", 71, 95, "kino_enhancements.png"},
    {"kino_boosters", 71, 95, "kino_boosters.png"},
    {"kino_confections", 71, 95, "kino_confections.png"},
    {"kino_tags", 34, 34, "kino_tags.png"},
    {"kino_vouchers", 71, 95, "kino_vouchers.png"},
    {"kino_stickers", 71, 95, "kino_stickers.png"},
    {"kino_ui", 40, 40, "kino_ui_assets.png"},
    {"kino_ui_large", 71, 95, "kino_ui_assets_cardsized.png"},
    {"kino_backs", 71, 95, "kino_backs.png"},
    {"kino_backs_genre", 71, 95, "kino_genre_backs.png"},
    {"kino_sleeves", 73, 95, "kino_sleeves.png"},
    {"kino_sleeves_genre", 73, 95, "kino_genre_sleeves.png"},
    {"kino_seg_display", 71, 95, "kino_seg_display.png"},
    {"kino_counters_jokers", 71, 95, "kino_retrigger_info.png"},
    {"kino_counters_pcards", 71, 95, "kino_counters_pcards.png"},
    {"kino_splash_screen", 409, 211, "kino_splash_sprite.png"},
    {'kino_atlas_legendary', 71, 95, 'kino_jokers_legendary.png'},
    {'non_suit_spells', 71, 95, 'non_suit_spells.png'},
    {'kino_bullets', 71, 95, 'kino_bullets.png'},

    -- -- Crossmod
    -- Cryptid
    {"kino_cryptid_consumables", 71, 95, "kino_cryptid.png"},
    {'kino_exotic', 71, 95, 'kino_exotic.png'},

    -- MoreFluff
    {"kino_morefluff_enhancements", 71, 95, "kino_morefluff_enhancements.png"},
    {"kino_mf_rotarots", 107, 107, "kino_rotarot.png"},
    {"kino_mf_time", 71, 71, "kino_timecard_special_asset.png"},
    {"kino_mf_rotisserie", 71, 95, "kino_chicken_spritesheet.png"},
}

for _index, _object in ipairs(non_jokeratlases) do
    SMODS.Atlas {
        key = _object[1],
        px = _object[2],
        py = _object[3],
        path = _object[4]
    }
end
-- New file loading code

function Kino.load_file(file_address)
    local helper, load_error = SMODS.load_file(file_address)
    if load_error then
        sendDebugMessage ("The error is: "..load_error)
        else
        helper()
    end
end

-- local _list_of_files = {
   
--     "card_ui.lua",
--     "kinofunctions.lua",
--     "jokers.lua",
--     "Kinogenres.lua",
--     "movie_info.lua",
-- }

-- for _index, _filename in ipairs(_list_of_files) do
--     Kino.load_file(_filename)
-- end

-- Read in Files
local _list_of_folders = {
    "src",
    "src/crossmod",
}

for _index, _folder in ipairs(_list_of_folders) do
    local files = NFS.getDirectoryItems(Kino.mod_dir .. _folder)
    for _, _filename in ipairs(files) do
        if _filename:match("%.lua$") then
            Kino.load_file(_folder .. "/" .. _filename)
        end
    end
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
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/jokers")
for _, joker in ipairs(_usedjokers) do
    assert(SMODS.load_file("items/jokers/" .. joker .. ".lua"))()
    Kino.jokers[#Kino.jokers + 1] = "j_kino_" .. joker
end

-- Register the Enhancements
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/enhancements")
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
        assert(SMODS.load_file("items/enhancements/" .. file))()
    end
end

-- Register the Card Blinds
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/blinds")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/blinds/" .. file))()
end

-- Register the Backs
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/backs")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/backs/" .. file))()
end

-- Register the Sleeves
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/sleeve")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/sleeve/" .. file))()
end

-- Register the Consumable Types
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/consumable_types")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/consumable_types/" .. file))()
end

-- Register the Counters
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/counters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/counters/" .. file))()
end

-- Register the CompatStandards
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/compat_standard")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/compat_standard/" .. file))()
end

-- Register the Consumables
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/consumables")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/consumables/" .. file))()
end

-- Register the Boosters
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/boosters")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/boosters/" .. file))()
end

-- Register the Vouchers
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/vouchers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/vouchers/" .. file))()
end

-- Register the Seals
local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/seals")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/seals/" .. file))()
end

local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/stickers")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/stickers/" .. file))()
end

local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/tags")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/tags/" .. file))()
end

if kino_config.spellcasting then
    local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/spells")
    for _, file in ipairs(files) do
        assert(SMODS.load_file("items/spells/" .. file))()
    end
end

local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/challenges")
for _, file in ipairs(files) do
    assert(SMODS.load_file("items/challenges/" .. file))()
end

-- local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/playsets")
-- for _, file in ipairs(files) do
--     assert(SMODS.load_file("items/playsets/" .. file))()
-- end

-- local files = NFS.getDirectoryItems(Kino.mod_dir .. "items/content_packages")
-- for _, file in ipairs(files) do
--     assert(SMODS.load_file("items/content_packages/" .. file))()
-- end


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

