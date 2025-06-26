Kino = {}
Kino.mod_dir = ''..SMODS.current_mod.path

kino_config = SMODS.current_mod.config

-- Kino = SMODS.current_mod
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
    key = "kino_atlas_legendary",
    px = 71,
    py = 95,
    path =  'kino_jokers_legendary.png'
}

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
    key = "kino_atlas_7",
    px = 71,
    py = 95,
    path =  'kino_jokers_7.png'
}
SMODS.Atlas {
    key = "kino_atlas_8",
    px = 71,
    py = 95,
    path =  'kino_jokers_8.png'
}
SMODS.Atlas {
    key = "kino_atlas_9",
    px = 71,
    py = 95,
    path =  'kino_jokers_9.png'
}

SMODS.Atlas {
    key = "kino_atlas_10",
    px = 71,
    py = 95,
    path =  'kino_jokers_10.png'
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
    key = "kino_sleeves",
    px = 73,
    py = 95,
    path = 'kino_sleeves.png'
}

SMODS.Atlas {
    key = "kino_seg_display",
    px = 71,
    py = 95,
    path = 'kino_seg_display.png'
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

local helper, load_error = SMODS.load_file("card_ui.lua")
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

local helper, load_error = SMODS.load_file("jokers.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

-- Add Kino mod specific game long globals
-- Scrap total
-- Matches Made
local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    

    ret.modifiers.genre_bonus = {}
    ret.last_played_hand = nil

    ret.current_round.scrap_total = 0
    ret.current_round.matches_made = 0
    ret.current_round.sci_fi_upgrades = 0
    ret.current_round.sci_fi_upgrades_last_round = 0
    ret.current_round.sacrifices_made = 0
    ret.current_round.kryptons_used = 0
    ret.current_round.beaten_run_high = 0
    ret.current_round.horror_transform = 0
    ret.current_round.cards_abducted = 0
    ret.money_stolen = 0
    ret.cards_destroyed = 0

    ret.current_round.actors_check = 3
    ret.current_round.actors_table_offset = 0
    ret.current_round.genre_synergy_treshold = 5
    
    -- Fantasy cards
    ret.current_round.spells_cast = 0
    ret.current_round.last_spell_cast = {
        key = "",
        rank = 1
    }
    ret.current_round.spell_queue = {
        -- should be {spell_key = KEY, strength = STRENGTH}
    }

    -- 

    ret.confections_used = 0
    ret.confections_powerboost = 0
    ret.confections_goldleaf_bonus = 1
    ret.current_round.confections_temp_boost = 0
    ret.current_round.confection_used = false

    ret.current_round.abduction_waitinglist = {}

    -- Joker Pool information
    ret.current_round.joker_queue = {}

    -- Boss Blind info
    ret.current_round.boss_blind_joker_counter = 0
    ret.current_round.boss_blind_blofeld_counter = 10000
    ret.current_round.boss_blind_agent_smith_rank_discards = {}
    ret.current_round.boss_blind_thanos_cards = {}

    -- -- Set up visual information 
    self.shared_indicator_sprites = {
        powerchange_sprite = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_ui"], {
                x = 6,
                y = 0
            }),
    }

    -- Setting up the Sci-fi display sprites
    self.shared_enhancement_sprites = {
        angelic_sprite = Sprite(0, 0, self.CARD_W, self.CARD_H,
            G.ASSET_ATLAS["kino_morefluff_enhancements"], {
                x = 0,
                y = 5
            }),
        time_sprite = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_morefluff_enhancements"], {
                x = 1,
                y = 5
            }),
        active_sprite = Sprite(0,0, self.CARD_W, self.CARD_W, 
            G.ASSET_ATLAS["kino_ui_large"], {
                x=0, 
                y=0
            }),
    }

    self.shared_segdisp = {
        {},
        {},
        {},
        {}
    }
    for i = 1, 14 do
        for j = 1, 4 do
            self.shared_segdisp[j][i] = Sprite(0, 0, self.CARD_W, self.CARD_H,
                G.ASSET_ATLAS["kino_seg_display"], {
                    x = i - 1,
                    y = 4 - j
                })
        end
    end

    ret.kino_genre_weight = {}
    for _, _genre in ipairs(kino_genres) do
        ret.kino_genre_weight[_genre] = 0
    end

    return ret
end

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

local helper, load_error = SMODS.load_file("src/abduction.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/codex.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/snack_bag.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/quest.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/malverk.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/per_card_rarity.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/powerchanges.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/create_card.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/start_run.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/cryptid.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/spritemanipulation.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

local helper, load_error = SMODS.load_file("src/consumable_functions.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
    else
    helper()
end

kino_genre_init()


--
-- SMODS.Keybind{
-- 	key = 'start_synergy_check',
-- 	key_pressed = 'a',
--     held_keys = {'rctrl'}, -- other key(s) that need to be held

--     action = function(self)
--         for i = 1, #G.jokers.cards do
--             G.jokers.cards[i]:kino_synergy(G.jokers.cards[i])
--         end
--     end,
-- }

-- SMODS.Keybind{
-- 	key = 'start_genre_check',
-- 	key_pressed = 's',
--     held_keys = {'rctrl'}, -- other key(s) that need to be held

--     action = function(self)
--         check_genre_synergy()
--     end,
-- }

