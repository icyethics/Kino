
local _occ = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if key_append == 'sho' or key_append == 'buf' then
        if G.GAME.current_round.joker_queue[_type] and #G.GAME.current_round.joker_queue[_type] > 0 then
            forced_key = G.GAME.current_round.joker_queue[_type][1].forced_key
            table.remove(G.GAME.current_round.joker_queue[_type], 1)
        end
    end
    
    local _card = _occ(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    -- Confection Changes --
    if G.GAME.used_vouchers.v_kino_special_treats and _type == "confection" then
        -- chance for golden 1/10
        -- chance for chocolate 1/10
        -- chance for XL 1/10 
        if pseudorandom("snack_boost_golden") < Kino.goldleaf_chance/10 then
            SMODS.Stickers['kino_goldleaf']:apply(_card, true)
        end
        if pseudorandom("snack_boost_choco") < Kino.choco_chance/10 then
            SMODS.Stickers['kino_choco']:apply(_card, true)
        end
        if pseudorandom("snack_boost_XL") < Kino.xl_chance/10 then
            SMODS.Stickers['kino_extra_large']:apply(_card, true)
        end
    end

    if next(find_joker("j_kino_charlie_and_the_chocolate_factory")) and _type == "confection" then
        if not _card.ability.kino_choco then
            SMODS.Stickers['kino_choco']:apply(_card, true)
        end
    end

    -- Joker Changes --
    if G.GAME.used_vouchers.v_kino_awardsbait and _type == 'Joker' then
        if _card.kino_joker then 
            if pseudorandom("snack_boost_golden") < Kino.awardschance/100 then
                SMODS.Stickers['kino_award']:apply(_card, true)
            end
        end
    end

    if G.GAME.modifiers.kino_bacon and _type == 'Joker' 
    and _card.kino_joker then
        SMODS.Stickers['kino_bacon']:apply(_card, true)
    end

    if G.GAME.modifiers.kino_batmandeck and _type == 'Joker' then
        if pseudorandom("kino_batmandeck") < (1/4) then
            SMODS.Stickers['kino_robin']:apply(_card, true)
        end
    end

    if G.GAME.modifiers and G.GAME.modifiers.genre_bonus then
        if _type == 'Joker' or genre_match(G.GAME.modifiers.genre_bonus, _type) then
            for _, _genre in ipairs(G.GAME.modifiers.genre_bonus) do
                if _card.config.center.k_genre and genre_match(_genre, _card.config.center.k_genre) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:set_multiplication_bonus(_card, 'card_back_' .. _genre, 1.5)
                            return true
                        end
                    }))
                end
            end
        end
    end

    return _card
end

function create_forced_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if not G.GAME.current_round.joker_queue[_type] then
        G.GAME.current_round.joker_queue[_type] = {}
    end
    
    G.GAME.current_round.joker_queue[_type][#G.GAME.current_round.joker_queue[_type] + 1] = {
        _type = _type,
        area = area,
        legendary = legendary,
        _rarity = _rarity,
        skip_materialize = skip_materialize,
        soulable = soulable,
        forced_key = forced_key,
        key_append = key_append
    }
end


-- If create card is called with a _type that is a table, overrule the pool
local _gcp = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
    G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
    local _pool, _starting_pool, _pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0
    if type(_type) == 'table' or
    (G.GAME.modifiers.kino_back_c2n and G.jokers and #G.jokers.cards > 0 and 
    (_append == "sho" or _append == "buf")) then
        local _castlist = create_cast_list()

        local rarity = _rarity or pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) 
        rarity = (_legendary and 4) or (rarity > 0.95 and 3) or (rarity > 0.7 and 2) or 1
        _starting_pool, _pool_key = G.P_JOKER_RARITY_POOLS[rarity], 'Joker'..rarity..((not _legendary and _append) or '')

        for k, v in ipairs(_starting_pool) do
            local add = nil

            if not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman"))) and
            (v.unlocked ~= false or v.rarity == 4) then
                if v.enhancement_gate then
                    add = nil
                    for kk, vv in pairs(G.playing_cards) do
                        if vv.config.center.key == v.enhancement_gate then
                            add = true
                        end
                    end
                else
                    add = true
                end
            else
                add = true
            end

            if v.no_pool_flag and G.GAME.pool_flags[v.no_pool_flag] then add = nil end
            if v.yes_pool_flag and not G.GAME.pool_flags[v.yes_pool_flag] then add = nil end

            if add and has_cast_from_table(v, _castlist) and
            not G.GAME.banned_keys[v.key] then 

                _pool[#_pool + 1] = v.key
                _pool_size = _pool_size + 1
            else
                _pool[#_pool + 1] = 'UNAVAILABLE'
            end
        end
        if _pool_size <= 6 then
            _type = 'Joker'
            _pool, _pool_key = _gcp(_type, _rarity, _legendary, _append)
        end
        _pool_key = _pool_key..(not _legendary and G.GAME.round_resets.ante or '')
        --
    else
        _pool, _pool_key = _gcp(_type, _rarity, _legendary, _append)
    end
    return _pool, _pool_key
end

function Kinodebug_forced_card(num)
    create_forced_card('Joker', nil, nil, nil, nil, nil, G.jokers.cards[num].config.center.key, "buf")

end