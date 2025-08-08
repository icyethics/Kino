SMODS.Enhancement {
    key = "crime",
    atlas = "kino_enhancements",
    pos = { x = 3, y = 1},
    config = {
        steal_val = 1,
        earn_val = 2
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.steal_val,
                card.ability.earn_val,
                G.GAME.money_stolen
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- New Effect, lower sell value of a joker or consumable by 1, if possible, and earn $2
        if (context.main_scoring and context.cardarea == G.play) then
            local _val = Kino:steal_money(card.ability.steal_val, card.ability.earn_val)

            if _val then
                return {
                    message = localize("k_crime_card"),

                }
            end
        end
    end
}

function Kino:steal_money(steal_num, earn_num)
    local _valid_targets = {}

    for _index, _joker in ipairs(G.jokers.cards) do
        if _joker.sell_cost > 0 then
            _valid_targets[#_valid_targets + 1] = _joker
        end
    end

    for _index, _con in ipairs(G.consumeables.cards) do
        if _con.sell_cost > 0 and _con ~= G.P_CENTERS.c_snackbag then
            _valid_targets[#_valid_targets + 1] = _con
        end
    end

    if #_valid_targets > 0 then
        local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_crimecard"))

        _target.ability.extra_value = _target.ability.extra_value - steal_num
        _target:set_cost()
        ease_dollars(earn_num)
        return Kino:increase_money_stolen(steal_num)
    end

    -- if to_big(G.GAME.dollars) > to_big(G.GAME.bankrupt_at + num) then
    --     ease_dollars(-num)
    --     return Kino:increase_money_stolen(num)
    -- end

    return false
end

function Kino:increase_money_stolen(num)
    G.GAME.money_stolen = G.GAME.money_stolen + num

    return G.GAME.money_stolen
end