-- Code for this feature is heavily based on code by nh6574
-- based on custom_pool.lua from JoyousSpring
if kino_config.custom_rarity then
Kino.complex_pool = function(_type, _rarity, _legendary, _append, starting_pool, default_key, key_append, allow_duplicates)
    -- local _starting_pool = get_current_pool(_type, _rarity, _legendary, _append)
    if _legendary then _rarity = "4" end
    local _starting_pool = _type and G.P_CENTER_POOLS[_type] or G.P_CENTER_POOLS["Joker"]
    G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
    local _pool = G.ARGS.TEMP_POOL


    local _castlist = nil

    if type(_type) == 'table' or
    (G.GAME.modifiers.kino_back_c2n and G.jokers and #G.jokers.cards > 0 and _type == 'Joker' and
    (_append == "sho" or _append == "buf")) then
        _castlist = create_cast_list()
    end

    -- tracking variables
    local _pool_size = 0
    local _total_weight = 0
    local _available_rarities = {}
    local _raritycount = 0
    if _legendary then 
        _rarity = 4
    end
    if _rarity then
        if _rarity == 0 then _rarity = 1 end
        _available_rarities[tostring(_rarity)] = {key = _rarity, weight = 1}
        _raritycount = 1
    else
        local _temp_rarities = (starting_pool and SMODS.ObjectTypes[_type]) and copy_table(SMODS.ObjectTypes[starting_pool].rarities) or {}
        for _, _rarity in ipairs(_temp_rarities) do

            local _key = _rarity.key
            if type(_key) == "string" then
                if _key == "Common" then _key = "1"
                elseif _key == "Uncommon" then _key = "2"
                elseif _key == "Rare" then _key = "3"
                elseif _key == "Legendary" then _key = "4"
                end
            end

            _available_rarities[_key] = _rarity
            _raritycount = _raritycount + 1
        end
    end


    -- Collect the total weights of all rarities
    local _rarity_weight = 0
    for _,v in pairs(_available_rarities) do
        v.mod = G.GAME[tostring(v.key):lower() .. "_mod"] or 1

        if SMODS.Rarities[v.key] and SMODS.Rarities[v.key].get_weight and type(SMODS.Rarities[v.key].get_weight) == "function" then
            v.weight = SMODS.Rarities[v.key]:get_weight(v.weight, SMODS.ObjectTypes[_type])
            if _rarity and v.key ~= _rarity then
                v.weight = 0
            elseif _rarity and v.key == _rarity then
                v.weight = 1
            end
        end

        _rarity_weight = _rarity_weight + v.weight
    end
    -- recalculate the weights as percentage of the total
    for _, v in pairs(_available_rarities) do
        v.weight = v.weight / _rarity_weight
    end
    for k, card in ipairs(_starting_pool) do
        local _cardobject = type(card) == "string" and G.P_CENTERS[card] or card

        local add = nil
        local in_pool, pool_opts
        if _cardobject.in_pool and type(_cardobject.in_pool) == 'function' then
            in_pool, pool_opts = _cardobject:in_pool({source = _append})
        end
        pool_opts = pool_opts or {}

        if not (G.GAME.used_jokers[_cardobject.key] and not pool_opts.allow_duplicates and not allow_duplicates and not next(find_joker("Showman"))) and
        (_cardobject.unlocked ~= false) and
        G.playing_cards then
            -- Check for enhancement gates
            if _cardobject.enhancement_gate then
                add = nil

                for kk, vv in pairs(G.playing_cards) do
                    if SMODS.has_enhancement(vv, _cardobject.enhancement_gate) then
                        add = true
                    end
                end
            else
                add = true
            end 

            -- Check for voucher availability
            if _cardobject.set == 'Voucher' then
                if not G.GAME.used_vouchers[_cardobject.key] then 
                    local include = true
                    if _cardobject.requires then 
                        for kk, vv in pairs(_cardobject.requires) do
                            if not G.GAME.used_vouchers[vv] then 
                                include = false
                            end
                        end
                    end                        
                    if G.shop_vouchers and G.shop_vouchers.cards then
                        for kk, vv in ipairs(G.shop_vouchers.cards) do
                            if vv.config.center.key == _cardobject.key then include = false end
                        end
                    end
                    if include then
                        add = true
                    end
                end

            -- Check for planet availability
            elseif _cardobject.set == 'Planet' then
                if _cardobject.config.softlock then
                    add = false
                    local _table = _cardobject.config.hand_type

                    if type(_cardobject.config.hand_type) == 'string' then
                        _table = {_cardobject.config.hand_type}
                    elseif _table == nil then
                        _table = {}
                    end

                    for _, _hand in ipairs(_table) do
                        if G.GAME.hands[_hand].played > 0 then
                            add = true
                            break
                        end
                    end
                end
            end

            if _cardobject.name == 'Black Hole' or _cardobject.name == 'The Soul' or _cardobject.hidden then
                add = false
            end
        end

        -- Checking flags
        if _cardobject.no_pool_flag and G.GAME.pool_flags[_cardobject.no_pool_flag] then add = nil end
        if _cardobject.yes_pool_flag and not G.GAME.pool_flags[_cardobject.yes_pool_flag] then add = nil end
        if _cardobject.in_pool and type(_cardobject.in_pool) == 'function' then
            add = in_pool and (add or pool_opts.override_base_checks)
        end
        
        -- Checking Kino joker settings
        if _cardobject.set == 'Joker' and not _cardobject.kino_joker and 
        ((kino_config and kino_config.movie_jokers_only) or
        G.GAME.modifiers.movie_jokers_only) then add = nil end

        -- Checking for Kino forced cast settings
        if _castlist and add and has_cast_from_table(_cardobject, _castlist) == false then
            add = nil
        end

        -- set weight and add to pool if not banned
        if add and not G.GAME.banned_keys[_cardobject.key] then
            
            local weight = _cardobject.rarity and _available_rarities[_cardobject.rarity] and _available_rarities[_cardobject.rarity].weight or 1
            local passtrue = true



            if _raritycount > 0 and (_cardobject.rarity and not _available_rarities[tostring(_cardobject.rarity)]) then
                weight = 0
            end

            if _cardobject.legendary_conditions and not _legendary then
                local _garb, rarity_test = _cardobject:legendary_conditions(self, _cardobject)
                rarity_test = tostring(6 - rarity_test)
                weight = _available_rarities[rarity_test] and _available_rarities[rarity_test].weight or 0
            end

            -- Force a legendary to spawn if the pool is legendary
            if _cardobject.rarity == "4" and _legendary then
                weight = 1
            end

            weight = Kino.modify_weight(_cardobject, weight)

            _total_weight = _total_weight + weight

            _pool[#_pool + 1] = {key = _cardobject.key, weight = weight}
            _pool_size = _pool_size + 1
        end
    end

    if _castlist and _pool_size <= 6 then
        _pool = Kino.complex_pool('Joker', _rarity, _legendary, _append .. "_test", starting_pool, default_key, key_append, allow_duplicates)
        _pool_size = #_pool
    end

    if _pool_size == 0 then
        _pool = EMPTY(G.ARGS.TEMP_POOL)
        _total_weight = 1
        if SMODS.ObjectTypes[_type] and SMODS.ObjectTypes[_type].default and G.P_CENTERS[SMODS.ObjectTypes[_type].default] then
            _pool[#_pool+1] = { key = default_key or SMODS.ObjectTypes[_type].default, weight = 1 }
        elseif _type == 'Tarot' or _type == 'Tarot_Planet' or _type == "Consumeables" then _pool[#_pool + 1] = { key = default_key or "c_strength", weight = 1 }
        elseif _type == 'Planet' then _pool[#_pool + 1] = { key = default_key or "c_pluto", weight = 1 }
        elseif _type == 'Spectral' then _pool[#_pool + 1] = { key = default_key or "c_incantation", weight = 1 }
        elseif _type == 'Joker' then _pool[#_pool + 1] = {key = default_key or "j_joker", weight = 1}
        elseif _type == 'Voucher' then _pool[#_pool + 1] = {key = default_key or "v_blank", weight = 1}
        elseif _type == 'Tag' then _pool[#_pool + 1] = {key = default_key or "tag_handy", weight = 1}
        else _pool[#_pool + 1] = {key = "j_joker", weight = 1}
        end
    end

    -- normalize the weights in the pool
    for _, _object in ipairs(_pool) do
        _object.weight = _object.weight / ((_total_weight > 0) and _total_weight or 1)
    end

    return _pool
end

Kino.modify_weight = function(card, starting_weight)
    local final_weight = starting_weight or 1

    -- Adjust for Rarity


    -- Adjust for Card
    local weight_mod_from_card = card.get_weight_mod and card:get_weight_mod() or 1

    -- Adjust for genre
    local weight_mod_from_genre = 0
    if card and card.k_genre then
        for _, _genre in ipairs(card.k_genre) do
            weight_mod_from_genre = weight_mod_from_genre + G.GAME.kino_genre_weight[_genre]
        end
    end
    
    
    -- Adjust for other features
    local weight_from_other_adjustments = 0

    -- BATMAN adjustment
    if G.GAME.modifiers.kino_batmandeck then
        if kino_quality_check(card, "is_batman") then 
            weight_from_other_adjustments = weight_from_other_adjustments +  G.GAME.modifiers.kino_batmandeck_rarity
        end
    end

    -- Star Wars Deck adjustments
    if G.GAME.modifiers.kino_starwarsdeck then
        if kino_quality_check(card, "is_starwars") then 
            weight_from_other_adjustments = weight_from_other_adjustments +  G.GAME.modifiers.kino_starwarsdeck_rarity
        end
    end

    -- Calc final weight
    final_weight = final_weight * (weight_mod_from_card + weight_mod_from_genre + weight_from_other_adjustments)
    return final_weight
end

Kino.get_complex_card = function(_type, _rarity, _legendary, _append, starting_pool, default_key, key_append, allow_duplicates)
    local poll = pseudorandom(pseudoseed('Kino_cardgen' .. G.GAME.round_resets.ante .. (key_append or '')))
    local pool = Kino.complex_pool(_type, _rarity, _legendary, _append, starting_pool, default_key, key_append, allow_duplicates)
    local weight_i = 0
    for _, v in ipairs(pool) do
        weight_i = weight_i + v.weight
        if poll < weight_i then
            return v.key
        end
    end
    return default_key or 'j_joker'
end

local o_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local key = nil

    --should pool be skipped with a forced key (ORIGINAL smods IMPLEMENTATION)
    if not forced_key and soulable and (not G.GAME.banned_keys['c_soul']) then
        for _, v in ipairs(SMODS.Consumable.legendaries) do
            if (_type == v.type.key or _type == v.soul_set) and not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman")) and not v.can_repeat_soul) and (not v.in_pool or (type(v.in_pool) ~= "function") or v:in_pool()) then
                if pseudorandom('soul_'..v.key.._type..G.GAME.round_resets.ante) > (1 - v.soul_rate) then
                    forced_key = v.key
                end
            end
        end
        if (_type == 'Tarot' or _type == 'Spectral' or _type == 'Tarot_Planet') and
        not (G.GAME.used_jokers['c_soul'] and not next(find_joker("Showman")))  then
            if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                forced_key = 'c_soul'
            end
        end
        if (_type == 'Planet' or _type == 'Spectral') and
        not (G.GAME.used_jokers['c_black_hole'] and not next(find_joker("Showman")))  then 
            if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                forced_key = 'c_black_hole'
            end
        end
    end

    if not forced_key and G.jokers and G.jokers.cards then
        local _rarity = (legendary and 4) or
            (type(_rarity) == "number" and ((_rarity > 0.95 and 3) or (_rarity > 0.7 and 2) or 1)) or _rarity
        _rarity = ({ Common = 1, Uncommon = 2, Rare = 3, Legendary = 4 })[_rarity] or _rarity
        key = Kino.get_complex_card(_type, _rarity, legendary, key_append, _type)
    end

    return o_create_card(_type, area, legendary, _rarity, skip_materialize, soulable,
        key or forced_key, key_append)
end

local o_smods_create_card = SMODS.create_card
function SMODS.create_card(t)
    local key = nil
    local _rarity = t.rarity
    if t.set == 'Joker' and not t.key then
        local _rarity = (type(_rarity) == "number" and ((_rarity > 0.95 and 3) or (_rarity > 0.7 and 2) or 1)) or _rarity
        _rarity = ({ Common = 1, Uncommon = 2, Rare = 3, Legendary = 4 })[_rarity] or _rarity
        key = Kino.get_complex_card(t.set, _rarity, t.legendary, t.key_append, t.set, "j_joker")
    end

    t.key = key or t.key

    return o_smods_create_card(t)
end

end