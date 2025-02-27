SMODS.Joker {
    key = "starman",
    order = 168,
    config = {
        extra = {
            mult = 1,
            match_made = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Romance", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.match_made then
            card.ability.extra.match_made = true
        end

        if context.joker_main and card.ability.extra.match_made then
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible then
                    upgrade_hand(card, v, 0, card.ability.extra.mult, 0, 0, true)
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_upgrade_ex'), colour = G.C.MULT})
                end
            end
        end
    end
}