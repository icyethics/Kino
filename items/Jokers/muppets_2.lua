SMODS.Joker {
    key = "muppets_2",
    order = 25,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 5,
            reroll_count_non = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 14900,
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
    k_genre = {"Comedy", "Musical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.reroll_count_non * card.ability.extra.mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop then
            card:juice_up()
            card.ability.extra.reroll_count_non = card.ability.extra.reroll_count_non + 1
            return {
                message = localize("k_kino_muppets_caper")
            }
        end

        if context.individual and context.cardarea == G.play and
        context.other_card:is_suit("Diamonds") then
            local _mult_given = card.ability.extra.reroll_count_non * card.ability.extra.mult
            return {
                mult = _mult_given,
                card = card
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and
        not context.blueprint and
        not context.repetition then
            card.ability.extra.reroll_count_non = 0
            return {
                message = localize("k_reset")
            }
        end
    
    end
}