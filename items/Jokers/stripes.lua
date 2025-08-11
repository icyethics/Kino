SMODS.Joker {
    key = "stripes",
    order = 69,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 1
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
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card is scored
        -- When you discard a card, -1 mult.
        if context.individual and context.cardarea == G.play then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
        end

        if context.discard and context.cardarea == G.jokers  and not context.blueprint then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips - card.ability.extra.a_chips
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end

    end
}