-- Code for this feature is heavily based on code by nh6574
-- based on custom_pool.lua from JoyousSpring

Kino.complex_pool = function(_type, _rarity, _legendary, _append, starting_pool, default_key, key_append, allow_duplicates)
    -- local _starting_pool = get_current_pool(_type, _rarity, _legendary, _append)
    local _starting_pool = starting_pool and G.P_CENTER_POOLS[starting_pool] or G.P_CENTER_POOLS["Joker"]
    G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
    local _pool = G.ARGS.TEMP_POOL

    -- tracking variables
    local _pool_size = 0
    local _total_weight = 0
    local _available_rarities = starting_pool and copy_table(SMODS.ObjectTypes[starting_pool].rarities) or copy_table(SMODS.ObjectTypes["Joker"].rarities)

    -- Collect the total weights of all rarities
    local _rarity_weight = 0
    for _,v in ipairs(_available_rarities) do
        v.mod = G.GAME[tostring(v.key):lower() .. "_mod"] or 1

        if SMODS.Rarities[v.key] and SMODS.Rarities[v.key].get_weight and type(SMODS.Rarities[v.key].get_weight) == "function" then
            v.weight = SMODS.Rarities[v.key]:get_weight(v.weight, SMODS.ObjectTypes[_type])
        end

        _rarity_weight = _rarity_weight + v.weight
    end

    -- recalculate the weights as percentage of the total
    for _, v in ipairs(_available_rarities) do
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
        (_cardobject.unlocked ~= false or _cardobject.rarity == 4) then
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
            if _cardobject.name == 'Black Hole' or _cardobject.name == 'The Soul' or _cardobject.hidden then
                add = false
            end
        end

        -- Checking flags
        if _cardobject.no_pool_flag and G.GAME.pool_flags[_cardobject.no_pool_flag] then add = nil end
        if _cardobject.yes_pool_flag and not G.GAME.pool_flags[_cardobject.yes_pool_flag] then add = nil end

        -- check for overrides
        -- if _cardobject.in_pool and type(_cardobject.in_pool) == 'function' then
        --     add = in_pool and (add or pool_opts.override_base_checks)
        -- end

        -- set weight and add to pool if not banned
        if add and not G.GAME.banned_keys[_cardobject.key] and _cardobject.rarity ~= 4 then
            local weight = _cardobject.rarity and _available_rarities[_cardobject.rarity] and _available_rarities[_cardobject.rarity].weight or 1
            weight = Kino.modify_weight(_cardobject, weight)

            _total_weight = _total_weight + weight

            _pool[#_pool + 1] = {key = _cardobject.key, weight = weight}
            
            _pool_size = _pool_size + 1
        end
    end

    if _pool_size == 0 then
        _pool = EMPTY(G.ARGS.TEMP_POOL)
        _total_weight = 1
        if SMODS.ObjectTypes[_type] and SMODS.ObjectTypes[_type].default and G.P_CENTERS[SMODS.ObjectTypes[_type].default] then
            _pool[#_pool+1] = { key = default_key or SMODS.ObjectTypes[_type].default, weight = 1 }
        elseif _type == 'Tarot' or _type == 'Tarot_Planet' then _pool[#_pool + 1] = { key = default_key or "c_strength", weight = 1 }
        elseif _type == 'Planet' then _pool[#_pool + 1] = { key = default_key or "c_pluto", weight = 1 }
        elseif _type == 'Spectral' then _pool[#_pool + 1] = { key = default_key or "c_incantation", weight = 1 }
        elseif _type == 'Joker' then _pool[#_pool + 1] = {key = default_key or "j_joker", weight = 1}
        elseif _type == 'Voucher' then _pool[#_pool + 1] = {key = default_key or "v_blank", weight = 1}
        elseif _type == 'Tag' then _pool[#_pool + 1] = {key = default_key or "tag_handy", weight = 1}
        else _pool[#_pool + 1] = "j_joker"
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
    local weight_mod_from_card = card.get_weight_mod and card:get_weight_mod() or 0

    -- Adjust for genre
    local weight_mod_from_genre = 0
    if card and card.k_genre then
        for _, _genre in ipairs(card.k_genre) do
            weight_mod_from_genre = weight_mod_from_genre + G.GAME.kino_genre_weight[_genre]
        end
    end
    
    
    -- Adjust for other features
    local weight_from_other_adjustments = 0
    -- Calc final weight
    final_weight = final_weight * (1 + weight_mod_from_card + weight_mod_from_genre + weight_from_other_adjustments)
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
    if not forced_key then
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
        key = Kino.get_complex_card(t.set, _rarity, "legendary", t.key_append, t.set, "j_joker")
    end

    t.key = key or t.key

    return o_smods_create_card(t)
end
