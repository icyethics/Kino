function Blockbuster.Counters.get_total_counters(types, targets)
    -- Types determines which counters to count
    -- Targets determines which objects to assess

    local countertypestocheck = {}
    if types then
        -- 
        if type(types) == "table" then
            for _index, _entry in ipairs(types) do
                if type(_entry) == "string" then
                    countertypestocheck[#countertypestocheck] = G.P_COUNTERS[_entry]
                else
                    countertypestocheck[#countertypestocheck] = _entry
                end
            end
        else 
            if type(types) == "string" then
                countertypestocheck[#countertypestocheck] = G.P_COUNTERS[types]
            else
                countertypestocheck[#countertypestocheck] = types
            end
        end

    else
        for _key, _entry in pairs(G.P_COUNTERS) do
            countertypestocheck[#countertypestocheck] = _entry
        end
    end

    local _total_counters = 0
    local _total_counter_values = 0

    if targets == "Joker" then
        for _index, _joker in ipairs(G.jokers.cards) do
            if _joker.counter then
                _total_counters = _total_counters + 1
                _total_counter_values = _total_counter_values + _joker.ability.counter.counter_num
            end
        end
    end
    
    return {
        counters = _total_counters,
        counter_values = _total_counter_values
    }
end

function Blockbuster.Counters.get_counter(card)
    if card.counter then
        return card.counter
    end
end

function Blockbuster.Counters.is_counter(card, counter_key)
    if card.counter then
        if card.counter.key == counter_key then
            return true
        end
        return false
    end
end

function Blockbuster.Counters.get_counter_num(card)
    if card.counter then
        return card.ability.counter.counter_num
    end
end

function Blockbuster.Counters.is_counter_of_class(card, counter_class_table)
    local _is_matching = false
    if type(counter_class_table) ~= "table" then
        counter_class_table = {counter_class_table}
    end

    if card.counter then
        for _index, _comparing_class in ipairs(counter_class_table) do
            for _index, _class in ipairs(card.counter.counter_class) do
                if _class ~= _comparing_class then
                    return false
                end
            end
        end
    end
    return _is_matching
end

-- accepted conditions parameters:
-- "none" = cards that have no counters on it
-- "match" = cards that DO have a counter, and that match the given counter type
-- "no_match" = cards that DO have a counter, and that DON'T match the given counter type
-- "match_class" = cards that DO have a counter, and that share the a class from the class table
-- "no_match_class" = cards that DO have a counter, and that DON'T share the a class from the class table
function Blockbuster.Counters.get_counter_targets(table_of_cards, conditions, counter_type, counter_class_table)
    local _return_list_of_cards = {}
    if type(counter_type) ~= "string" then
        counter_type = counter_type.key
    end

    if type(conditions) ~= 'table' then
        conditions = {conditions}
    end

    for _index, _pcard in ipairs(table_of_cards) do
        local _will_add = false
        for _index2, _condition in ipairs(conditions) do
            if _condition == nil or _condition == "none" then
                if not Blockbuster.Counters.get_counter(_pcard) then
                    _will_add = true
                end
            elseif _condition == "match" and counter_type then
                if Blockbuster.Counters.is_counter(_pcard, counter_type) then
                    _will_add = true
                end 
            elseif _condition == "no_match" and counter_type then
                if Blockbuster.Counters.is_counter(_pcard, counter_type) == false then
                    _will_add = true
                end 
            elseif _condition == "match_class" and counter_class_table then
                if Blockbuster.Counters.is_counter_of_class(_pcard, counter_class_table) then
                    _will_add = true
                end
            elseif _condition == "no_match_class" and counter_class_table then
                if Blockbuster.Counters.is_counter_of_class(_pcard, counter_class_table) == false then
                    _will_add = true
                end
            end

            if _will_add == true then break end
        end



        if _will_add then
            _return_list_of_cards[#_return_list_of_cards + 1] = _pcard
        end
    end
    return _return_list_of_cards
end

function Blockbuster.Counters.get_counter_pool(counter_class_table, key_only)
    local _returntable = {}

    for _key, _object in pairs(G.P_COUNTERS) do
        local _addtolist_matches = 0
        for _index, _comparing_class in ipairs(counter_class_table) do
            for _index, _class in ipairs(_object.counter_class) do
                if _class == _comparing_class then
                    _addtolist_matches = _addtolist_matches + 1
                end
            end
        end
        
        if _addtolist_matches == #counter_class_table then
            if key_only then
                _returntable[#_returntable + 1] = _key
            else
                _returntable[#_returntable + 1] = _object
            end
           
        end
    end
    return _returntable
end