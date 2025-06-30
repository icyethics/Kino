SMODS.Joker {
    key = "captain_blood",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1,
            money_earned_non = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 4, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Action", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.money_earned_non * card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.kino_ease_dollars and to_big(context.kino_ease_dollars) > to_big(0) and not context.blueprint then
            card.ability.extra.money_earned_non = card.ability.extra.money_earned_non + context.kino_ease_dollars
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.money_earned_non * card.ability.extra.mult
            }
        end

        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.money_earned_non = 0
        end
    end,
}