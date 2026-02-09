SMODS.Joker {
    key = "duel",
    order = 89,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 100,
            cur_chance = 1,
            chance = 100
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
    k_genre = {"Horror", "Thriller"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.cur_chance, card.ability.extra.chance, "kino_duel")
         

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
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end

        if context.after then
            if not context.blueprint then
                if SMODS.pseudorandom_probability(card, 'kino_duel', card.ability.extra.cur_chance, card.ability.extra.chance, "kino_duel") then
                    card:start_dissolve()
                end
            end

            if not next(context.poker_hands['Straight']) then
                card.ability.extra.cur_chance = math.min(card.ability.extra.cur_chance * 2, card.ability.extra.chance)
            end
        end
    end
}