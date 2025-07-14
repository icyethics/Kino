SMODS.Joker {
    key = "duel",
    order = 89,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 150,
            chance = 4
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 839,
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
    pools, k_genre = {"Horror", "Thriller"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (G.GAME.probabilities.normal), card.ability.extra.chance, "kino_chips")
         

        return {
            vars = {
                card.ability.extra.chips,
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- when you play a straight, 3/4 chance to give 150 chips.
        if context.joker_main and next(context.poker_hands['Straight']) then
            -- if pseudorandom("duel") > G.GAME.probabilities.normal / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_duel', (G.GAME.probabilities.normal), card.ability.extra.chance, "kino_chips") then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
}