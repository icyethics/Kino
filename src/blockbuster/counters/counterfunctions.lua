function BlockbusterCounters.get_total_counters(types, targets)
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
                _total_counter_values = _total_counter_values + _joker.counter_config.counter_num
            end
        end
    end
    
    return {
        counters = _total_counters,
        counter_values = _total_counter_values
    }
end

function BlockbusterCounters.get_counter(card)
    if card.counter then
        return card.counter
    end
end

function BlockbusterCounters.is_counter(card, counter_key)
    if card.counter then
        if card.counter.key == counter_key then
            return true
        end
        return false
    end
end