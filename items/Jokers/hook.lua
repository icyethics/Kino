SMODS.Joker {
    key = "hook",
    order = 94,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 3},
    cost = 2,
    blueprint_compat = false,
    perishable_compat = true,
    pools, k_genre = {"Fantasy", "Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- Turn scored face cards into random non-face card
        if context.after then 
            for i = 1, #context.scoring_hand do
                local i_card = context.scoring_hand[i]
                if i_card:is_face() then
                    local _ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10"}
                    local _rank = pseudorandom_element(_ranks, pseudoseed("hook"))                    
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                        i_card:juice_up(0.8, 0.5)
                        card:juice_up(0.8, 0.5)
                        card_eval_status_text(i_card, 'extra', nil, nil, nil,
                        { message = localize('k_hook'), colour = G.C.MULT })
                        SMODS.change_base(i_card, nil, _rank)
                        delay(0.23)
                    return true end }))
                end
            end 
        end
    end
}