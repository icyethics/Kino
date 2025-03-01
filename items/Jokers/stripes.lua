SMODS.Joker {
    key = "stripes",
    order = 69,
    config = {
        extra = {
            mult = 0,
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 5},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10890,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card is scored
        -- When you discard a card, -1 mult.
        if context.individual and context.cardarea == G.play then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
        end

        if context.discard and context.cardarea == G.jokers  and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult - (card.ability.extra.a_mult * #context.full_hand)
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

    end
}