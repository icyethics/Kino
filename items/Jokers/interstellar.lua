SMODS.Joker {
    key = "interstellar",
    order = 106,
    config = {
        extra = {
            stacks = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 5},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you use a planet, it doesn't trigger.
        -- Instead, add a counter to this Joker
        -- Then, when you sell this joker, upgrade your most played hand that many times.
        if context.interstellar then
            card.ability.extra.stacks = card.ability.extra.stacks + 1
            return {
                card = card,
                message = localize('k_upgrade_ex')
            }
        end

        if context.selling_self and not context.blueprint then
            print("test")
            -- get most played hand
            local _planet, _hand, _tally = nil, nil, 0
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end

            level_up_hand(card, _hand, nil, card.ability.extra.stacks, true)
        end
    end
}