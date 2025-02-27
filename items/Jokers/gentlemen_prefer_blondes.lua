SMODS.Joker {
    key = "gentlemen_prefer_blondes",
    order = 17,
    config = {
        extra = {
            starting_amount = 13,
            mult = 0,
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Musical", "Romance", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}

        local suit_count = 0 
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.config.card.suit == "Diamonds" and v.config.center ~= G.P_CENTERS.m_stone then
                    suit_count = suit_count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.starting_amount,
                card.ability.extra.mult,
                card.ability.extra.a_mult,
                suit_count * card.ability.extra.a_mult - card.ability.extra.starting_amount,
            }
        }
    end,
    calculate = function(self, card, context)
        if G.STAGE == G.STAGES.RUN then
        -- Diamonds give +1 for each diamond in your deck above 13
            local suit_count = 0 
            for k, v in pairs(G.playing_cards) do
                if v.config.card.suit == "Diamonds" and v.config.center ~= G.P_CENTERS.m_stone then
                    suit_count = suit_count + 1
                end
            end
            card.ability.extra.mult = suit_count - card.ability.extra.starting_amount
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Diamonds") then
                return {
                    mult = card.ability.extra.mod,
                    card = context.other_card
                }
            end
        end
    end
}