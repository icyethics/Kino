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

SMODS.Keybind({
    key_pressed = "n",
    held_keys = { "space" },
    action = function(self)
        if G and G.CONTROLLER and G.CONTROLLER.hovering.target and G.CONTROLLER.hovering.target:is(Card) then
            local _card = G.CONTROLLER.hovering.target

            for _i, _counter in ipairs(GetCounters()) do
                if (_card.counter and _card.counter.key or "None") == _counter then
                    local _next = _i + 1
                    if _next > #counters then
                        _next = 1
                    end

                    if _next == 1 then
                        _card:bb_counter_apply(nil, 0)
                    else
                        _card:bb_counter_apply(counters[_next], 1)
                    end
                    break
                end
            end
        end

    end
})

SMODS.Keybind({
    key_pressed = "n",
    held_keys = { "ralt" },
    event = 'pressed',
    action = function(self)
        if G and G.CONTROLLER and G.CONTROLLER.hovering.target and G.CONTROLLER.hovering.target:is(Card) then
            local _card = G.CONTROLLER.hovering.target
            _card:bb_increment_counter(1)
        end
    end
})

SMODS.Keybind({
    key_pressed = "n",
    held_keys = { "lalt" },
    event = 'pressed',
    action = function(self)
        if G and G.CONTROLLER and G.CONTROLLER.hovering.target and G.CONTROLLER.hovering.target:is(Card) then
            local _card = G.CONTROLLER.hovering.target
            _card:bb_increment_counter(-1)
        end
    end
})

