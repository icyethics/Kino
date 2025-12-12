local _o_gsr = Game.start_run
function Game:start_run(args)
    local ret = _o_gsr(self, args)

    -- args.playset = Blockbuster.Playset.Playsets["kino_standardsize_movies"]
    -- args.playset = Blockbuster.Playset.Playsets["kino_science_pack"]

    if args.playset then
        -- load in item legality
        local _playset = args.playset
        local _legal_items = {}
        local _banned_items = {}
        local _DEBUG_count = 0
        local _legal_sets = args.playset.sets or {}

        local DEBUG_hash = {}

        for _package_key, _bool in pairs(_playset.packages) do
            local _content_package = Blockbuster.Playset.ContentPackages[_package_key]
            if _content_package ~= nil then
            else
                print("Could not find " .. _package_key)
            end

            if _content_package and _content_package.items then
                for _key, _ in pairs(_content_package.items) do
                    if _bool == true then
                        _legal_items[_key] = true
                    else
                        _banned_items[_key] = true
                    end
                    _DEBUG_count = _DEBUG_count + 1
                end
            end



            if _content_package and _content_package.sets then
                for _index, _set in ipairs(_content_package.sets) do
                    _legal_sets[_set] = true
                end
            end
        end

        -- ban and whitelist items
        for _key, _object in pairs(G.P_CENTERS) do
            if _legal_sets[_object.set] then
                if _legal_items[_key] then
                    DEBUG_hash[_key] = true
                end

                if _banned_items[_key] or not _legal_items[_key] then
                    G.GAME.banned_keys[_key] = true
                end
            end
        end

        -- DEBUG ONLY: REMOVE
        -- Prints keys included but not found in the check
        -- print("DEBUG CHECK: tested for each of these sets: ")
        -- print(_legal_sets)
        -- print("DEBUG COUNT: Playset should include " .. _DEBUG_count .. " items")
        -- for _key, _bool in pairs(_legal_items) do
        --     if not DEBUG_hash[_key] then print("DEBUG CHECK: " .. _key .. " was included in the playset but does not exist") end
        -- end


    end

    return ret
end

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    Blockbuster.Playset.generate_base_playsets()
    return ret
end