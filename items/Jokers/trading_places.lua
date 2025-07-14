SMODS.Joker {
    key = "trading_places",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_xmult = 1,
            a_xmult = 0.5,
            threshold = 6
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1621,
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
                card.ability.extra.stacked_xmult,
                card.ability.extra.a_xmult,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card then
            if to_big(context.card.sell_cost) > to_big(card.ability.extra.threshold) then
                card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end
    end
}