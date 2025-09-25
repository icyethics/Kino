-- This file is intended as the loading hub for the Blockbuster API modifiers
-- that Kino inherently provides

if not Blockbuster then
    Blockbuster = {}
end
Blockbuster.Counters = {}
Blockbuster.Spellcasting = {}
Blockbuster.mod_dir = ''..SMODS.current_mod.path

Blockbuster.Counters.disabledCounters = {
    
}

local atlases = 
{
    {'blockbuster_counters', 73, 97, 'bbcount_counters.png'},
    {'suit_spells', 71, 95, 'blockbuster_spells.png'},
    {'non_suit_spells', 71, 95, 'non_suit_spells.png'}
}

for _index, _object in ipairs(atlases) do
    SMODS.Atlas {
        key = _object[1],
        px = _object[2],
        py = _object[3],
        path = _object[4]
    }
end

-- Read in Files
function Blockbuster.load_file(file_address)
    local helper, load_error = SMODS.load_file(file_address)
    if load_error then
        sendDebugMessage ("The error is: "..load_error)
    else
        helper()
    end
end

local _list_of_folders = {
    "src/blockbuster/counters",
    "src/blockbuster/spells",
}

for _index, _folder in ipairs(_list_of_folders) do
    local files = NFS.getDirectoryItems(Blockbuster.mod_dir .. _folder)
    for _, _filename in ipairs(files) do
        Blockbuster.load_file(_folder .. "/" .. _filename)
    end
end