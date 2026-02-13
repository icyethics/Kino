local counters = nil
local timesused = 0
function GetCounters()
    if counters then
        return counters
    end

    counters = {"None"}
    for i, v in pairs(G.P_COUNTERS) do
        counters[v.order + 1] = i
    end

    return counters
end

---Class containing debug functions for testing purposes
---@class Debug
Blockbuster.Debug = {}

---Prints the standard of the given card.
---@param arg number|string key of joker or number indicating position of joker in G.jokers
---@return boolean
function Blockbuster.Debug.printStandards(arg)
    if type(arg) == "string" then
        print(Blockbuster.get_standard_from_card(arg))
        return true
    elseif type(arg) == "number" then
        if G.jokers and G.jokers.cards[arg] ~= nil then
            print(Blockbuster.get_standard_from_card(G.jokers.cards[arg]))
            return true
        end
    end

    return false
end

---Prints keys of all variables on object
---@param arg number|string key of joker or number indicating position of joker in G.jokers
---@return boolean
function Blockbuster.Debug.cardPrintValueKeys(arg)
    local _card = nil 
    if type(arg) == "string" then
        _card = G.P_CENTERS[arg]
    elseif type(arg) == "number" then
        if G.jokers and G.jokers.cards[arg] ~= nil then
            _card = G.P_CENTERS[G.jokers.cards[arg]]
        end
    end

    if _card then
        for _key, _value in ipairs(_card.config.ability) do
            print("ability." .. _key)
        end
        for _key, _value in ipairs(_card.config.ability.extra) do
            print("ability.extra." .. _key)
        end
        return true
    else
        return false
    end
end

---Prints key and value stored if joker has given variable
---@param arg number|string key of joker or number indicating position of joker in G.jokers
---@param value string Key of variable
---@param base boolean If true, returns base value instead of current
---@return boolean
function Blockbuster.Debug.cardHasValue(arg, value, base)
    local _card = nil 
    if type(arg) == "string" then
        _card = G.P_CENTERS[arg]
    elseif type(arg) == "number" then
        if G.jokers and G.jokers.cards[arg] ~= nil then
            if base then
                _card = G.P_CENTERS[G.jokers.cards[arg]]
            else
                _card = G.jokers.cards[arg]
            end
        end
    end

    if _card then
        for _key, _value in ipairs(_card.config.ability.extra) do
            if _key == value then
                print(_key .. ": " .. _value)
                return true
            end
        end
    end

    return false
end

---Manipulated values of given joker
---@param target number|string key of joker or number indicating position of joker in G.jokers
---@param value number Number that value will by multiplied with
---@param key? string Key used to store manipulation (Defaults to 'debug')
function Blockbuster.Debug.valManipTarget(target, value, key)
    local _card = nil
    if type(target) == "string" then
        for _index, _joker in ipairs(G.jokers.cards) do
            if _joker.config.center.key == target then
                _card = _joker
            end
        end
    elseif type(target) == "number" then
        if G.jokers and G.jokers.cards[target] ~= nil then
            _card = G.jokers.cards[target]
        end
    end

    if not key then key = "debug" end

    Blockbuster.manipulate_value(_card, key, value)
    card_eval_status_text(_card, 'extra', nil, nil, nil,
    { message = "x" .. value .. " VALUE (DEBUG)", colour = G.C.BLACK })
end

---Resets value of specific manipulation source
---@param target number|string key of joker or number indicating position of joker in G.jokers
---@param key? string Key used to store manipulation (Defaults to 'debug')
function Blockbuster.Debug.resetManipTarget(target, key)
    local _card = nil
    if type(target) == "string" then
        for _index, _joker in ipairs(G.jokers.cards) do
            if _joker.config.center.key == target then
                _card = _joker
            end
        end
    elseif type(target) == "number" then
        if G.jokers and G.jokers.cards[target] ~= nil then
            _card = G.jokers.cards[target]
        end
    end

    if not key then key = "debug" end

    Blockbuster.manipulate_value(_card, key, 1)
    card_eval_status_text(_card, 'extra', nil, nil, nil,
    { message = "RESET VALUE(S) (DEBUG)", colour = G.C.BLACK })
end

---Prints key of every joker that has an extra table
function Blockbuster.Debug.hasExtra()
    print("Function Called:")
    local _index = 0
    for _key, _object in pairs(G.P_CENTERS) do
        _index = _index + 1
        -- print(_index .. ": " .. _key)
        if _object.set == "Joker" then
            if _object.config then
                if _object.config.extra then
                    
                else
                    print(_key)
                end
            end
        end
    end
end

---Prints current Manipulation value from each source, for each joker
function Blockbuster.Debug.valManipMult()
    print("Function Called:")
    local _index = 0
    for _index, _object in ipairs(G.jokers.cards) do
        if _object.ability and _object.ability.blockbuster_multipliers then
            for _source, _mult in pairs(_object.ability.blockbuster_multipliers) do
                print(_source .. ": x" .. _mult)
            end
        end
    end
end

function bb_constest(val)
    Blockbuster.manipulate_value(G.consumeables.cards[1], 'r', val or 2)
end
function bb_handtest(val)
    Blockbuster.manipulate_value(G.hand.cards[1], 'r', val or 2)
end
function bb_handtest2(val)
    for _index, _card in ipairs(G.hand.cards) do
        Blockbuster.manipulate_value(_card, 'r', val or 2, {Base = true})
    end
   
end

DebugMode = true
function DebugPrint(args)
    if DebugMode then
        print(args)
    end
end
-- SMODS.Keybind({
--     key_pressed = "k",
--     held_keys = { "space" },
--     action = function(self)
--         if G and G.CONTROLLER and G.CONTROLLER.hovering.target and G.CONTROLLER.hovering.target:is(Card) then
--             local _card = G.CONTROLLER.hovering.target
--             for _index, _joker in ipairs(G.jokers.cards) do
--                 if _joker.config.center and _joker.config.center.original_mod then
--                 end
--                 -- print(_joker.mod.id)
--                 local _value = 10
--                 Blockbuster.manipulate_value(_joker, "debug", _value)
--                 card_eval_status_text(_joker, 'extra', nil, nil, nil,
--                 { message = "x" .. _value .. " VALUE (DEBUG)", colour = G.C.BLACK })
--             end

--         end

--     end
-- })

-- SMODS.Keybind({
--     key_pressed = "k",
--     held_keys = { "ralt" },
--     event = 'pressed',
--     action = function(self)
--         if G and G.CONTROLLER and G.CONTROLLER.hovering.target and G.CONTROLLER.hovering.target:is(Card) then
--             local _card = G.CONTROLLER.hovering.target
--             for _index, _joker in ipairs(G.jokers.cards) do
--                 if _joker.config.center and _joker.config.center.original_mod then
--                     print(_joker.config.center.original_mod.id)
--                 end
--                 Blockbuster.manipulate_value(_joker, "debug", 1)
--                 card_eval_status_text(_joker, 'extra', nil, nil, nil,
--                 { message = "RESET VALUE (DEBUG)", colour = G.C.BLACK })
--             end
--         end
--     end
-- })

