SMODS.Joker {
    key = "wall_street",
    order = 29,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 1,
            chance = 20,
            division_non = 10
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = false,
    perishable_compat = false,
    kino_joker = {
        id = 10673,
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
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card,  G.GAME.probabilities.normal, card.ability.extra.chance, "kino_joker_valuemanipulation")
        return {
            vars = {
                card.ability.extra.money,
                new_numerator,
                new_denominator,
                card.ability.extra.division_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you discard a card, increase the sell value of this card by 1. When you play a hand, 1/20 chance to divide the sell value of this card by 10
        if context.discard and not context.blueprint then
            card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.money
            card:set_cost()
        end

        if context.joker_main and not context.blueprint then
            -- if pseudorandom("wall_street") < G.GAME.probabilities.normal / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_wall_street', G.GAME.probabilities.normal, card.ability.extra.chance, "kino_joker_valuemanipulation") then
                card.ability.extra_value = (card.ability.extra_value or 0) / card.ability.extra.division_non
            end
        end
    end
}