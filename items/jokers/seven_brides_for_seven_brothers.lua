SMODS.Joker {
    key = "seven_brides_for_seven_brothers",
    order = 163,
    config = {
        extra = {
            a_xmult = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    k_genre = {"Romance", "Musical"},

    loc_vars = function(self, info_queue, card)
        local _king_tally = 0
        local _queen_tally = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:get_id() == 13 then _king_tally  = _king_tally  + 1 end
                if v:get_id() == 12 then _queen_tally  = _queen_tally  + 1 end
            end
        end
        return {
            vars = {
                card.ability.extra.a_xmult,
                _king_tally,
                _queen_tally
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives 2 xmult if your deck contains an equal number of kings and queens

        if context.joker_main then
            local _king_tally = 0
            local _queen_tally = 0
            if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v:get_id() == 13 then _king_tally  = _king_tally  + 1 end
                    if v:get_id() == 12 then _queen_tally  = _queen_tally  + 1 end
                end

                if _king_tally == _queen_tally then
                    return {
                        x_mult = card.ability.extra.a_xmult
                    }
                end
            end
        end
    end
}