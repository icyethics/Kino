SMODS.Joker {
    key = "krazy_house",
    order = 116,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips_non = 30,
            mult_non = 4,
            xmult_non = 0.5,
            factor = 50
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 1},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 607338,
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
    k_genre = {"Horror", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_non,
                card.ability.extra.mult_non,
                1 + card.ability.extra.xmult_non,
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Full House']) then
            local _randomizer = pseudorandom("kino_krazy_house")
            local _randomizer2 = pseudorandom("kino_krazy_house_2")
            local _factor = (1 + (card.ability.extra.factor / 100))
            if _randomizer > 0.66 then
                if _randomizer2 > 0.5 then
                    card.ability.extra.mult_non = card.ability.extra.mult_non * _factor
                else
                    card.ability.extra.xmult_non = card.ability.extra.xmult_non * _factor
                end
                return {
                    chips = card.ability.extra.chips_non
                }
            elseif _randomizer > 0.33 then
                if _randomizer2 > 0.5 then
                    card.ability.extra.chips_non = card.ability.extra.chips_non * _factor
                else
                    card.ability.extra.xmult_non = card.ability.extra.xmult_non * _factor
                end
                return {
                    mult = card.ability.extra.mult_non
                }
            else
                if _randomizer2 > 0.5 then
                    card.ability.extra.chips_non = card.ability.extra.chips_non * _factor
                else
                    card.ability.extra.mult_non = card.ability.extra.mult_non * _factor
                end
                return {
                    x_mult = 1 + card.ability.extra.xmult_non
                }
            end
        end
    end
}
