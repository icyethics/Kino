-- Code that is ran after the mod is loaded in
Blockbuster.Playset.startup = {}

Blockbuster.Playset.categories = {
    full = {
        Prefix = {"m_", "j_", "c_", "tag_", "bl_", "v_"},
        Set = {}
    },
    enhancements = {
        Prefix = {"m_"},
        Set = {"Enhanced"}
    },
    editions = {
        Prefix = {"e_"},
        Set = {"Edition"}
    },
    jokers = {
        Prefix = {"j_"},
        Set = {"Joker"}
    },
    consumables = {
        Prefix = {"c_"},
        Set = {"Planet", "Tarot", "Spectral"}
    },
    planets = {
        Prefix = {"c_"},
        Set = {"Planet"}
    },
    tarots = {
        Prefix = {"c_"},
        Set = {"Tarot"}
    },
    spectrals = {
        Prefix = {"c_"},
        Set = {"Spectral"}
    },
    vouchers = {
        Prefix = {"v_"},
        Set = {"Voucher"}
    },
    boosters = {
        Prefix = {"p_"},
        Set = {"Booster"}
    },
    -- tags = {"tag_"},
    -- blinds = {"bl_"},
}

Blockbuster.Playset.Hash = {}
Blockbuster.Playset.Hash.generate_playset_has_run = false
function Blockbuster.Playset.generate_base_playsets()

    if Blockbuster.Playset.Hash.generate_playset_has_run then
        return
    end
    Blockbuster.Playset.Hash.generate_playset_has_run = true

    -- Collects loaded mods
    local _list_of_mods = {
        "Vanilla"
    }
    for _mod_key, _mod in pairs(SMODS.Mods) do
        
        if _mod.can_load then 
            _list_of_mods[#_list_of_mods+1] = _mod_key 
        end
    end
    -- iterate over mods
    for _index, _modID in ipairs(_list_of_mods) do
        -- make one for every category
        for _categoryKey, _info in pairs(Blockbuster.Playset.categories) do

            local _valid_keys = {}
            local _count = 0
            local _first_key

            for _key, _object in pairs(G.P_CENTERS) do

                -- If object key matches then
                for _, _set_key in ipairs(_info.Set) do
                    if _set_key == _object.set then
                        for i = 1, #_info.Prefix do
                            if string.sub(_key, 0, #_info.Prefix[i]) == _info.Prefix[i] then
                                local _modID_object = Blockbuster.get_mod_id_from_card(_key)
                                if _modID_object == _modID then
                                    _valid_keys[_key] = true
                                    if _first_key == nil and not _object.no_collection then
                                        _first_key = _key
                                    end
                                    _count = _count + 1
                                end
                            end
                        end
                    end
                end
            end

            if _first_key == nil then
                _first_key = 'j_joker'
            end

            -- make content package object
            if _count > 0 then
                local _category = ""
                if _info and _info.Set then
                    if #_info.Set > 1 then
                        for _deepIndex, _setString in ipairs(_info.Set) do
                            _category = _category .. _setString 
                            if _deepIndex == #_info.Set then
                                _category = _category .. " "
                            elseif _deepIndex + 1 == #_info.Set then
                                _category = _category .. " & "
                            else
                                _category = _category .. ", "
                            end
                        end
                    else
                        _category = _info.Set[1]
                    end
                end

                
                local _description = {
                    "All " .. _category .. " content",
                    "from " .. _modID
                }

                Blockbuster.Playset.ContentPackage {
                    key = "all_" .. string.lower(_modID) .. "_" .. string.lower(_categoryKey),
                    name = "All " .. _modID .. " " .. _category,
                    loc_txt = { 
                        name = "All " .. _modID .. " " .. _category, 
                        text = _description 
                    },
                    prefix_config = {key = { mod = false, atlas = false}},
                    displayImage = _first_key,
                    types = {"Default"},
                    items = _valid_keys,
                    sets = _info.Set,
                    mods = {
                        _modID
                    }
                }
            end
        end
    end
end

function Blockbuster.Playset.register_new_Blockbuster(key, prefix, set, is_consumable)
    
    local _temp = "NONE"
    if key and type(key) == 'string' then _temp = key end
    print("Registering " .. _temp .. " as new object type")
    print(key)
    print(prefix)
    print(set)
    print(is_consumable)
    
    local _ret = {
        Prefix = {},
        Set = {}
    }
    Blockbuster.Playset.categories[key] = {
        Prefix = {},
        Set = {}
    }
    
    _ret.Prefix[1] = prefix
    _ret.Set[1] = set
    Blockbuster.Playset.categories.full.Prefix[#Blockbuster.Playset.categories.full.Prefix + 1] = prefix
    Blockbuster.Playset.categories.full.Set[#Blockbuster.Playset.categories.full.Set + 1] = set  
    Blockbuster.Playset.categories[key].Prefix[1] = prefix
    Blockbuster.Playset.categories[key].Set[1] = set

    if is_consumable then
        Blockbuster.Playset.categories.consumables.Prefix[#Blockbuster.Playset.categories.consumables.Prefix + 1] = prefix
        Blockbuster.Playset.categories.consumables.Set[#Blockbuster.Playset.categories.consumables.Set + 1] = set  
    end
    return _ret
end