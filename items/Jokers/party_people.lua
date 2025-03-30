SMODS.Joker {
    key = "party_people",
    order = 27,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            income = 1,
            threshold = 5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 4},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2750,
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
    pools, k_genre = {"Biopic", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.income,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives money equal to interest when scoring a club card.
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                local money = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / card.ability.extra.threshold)
                return {
                    dollars = to_number(money),
                    card = context.other_card
                }
            end
        end
    end
}