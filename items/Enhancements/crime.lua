SMODS.Enhancement {
    key = "crime",
    atlas = "kino_enhancements",
    pos = { x = 3, y = 1},
    config = {
        steal_val = 1,
        a_chips = 5
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.steal_val,
                card.ability.a_chips,
                G.GAME.money_stolen
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if (context.main_scoring and context.cardarea == G.play) then
            local _val = Kino:steal_money(card.ability.steal_val)

            if _val then
                return {
                    message = localize("k_crime_card"),

                }
            end
        end

        if (context.main_scoring and context.cardarea == G.hand and not context.end_of_round ) then
            return {
                chips = G.GAME.money_stolen * card.ability.a_chips
            }
        end
    end
}

function Kino:steal_money(num)
    if to_big(G.GAME.dollars) > to_big(G.GAME.bankrupt_at + num) then
        ease_dollars(-num)
        return Kino:increase_money_stolen(num)
    end

    return false
end

function Kino:increase_money_stolen(num)
    G.GAME.money_stolen = G.GAME.money_stolen + num

    return G.GAME.money_stolen
end