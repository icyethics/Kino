SMODS.Joker {
    key = "angel_hearts",
    order = 26,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            starting_mult = 1,
            mult = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 4},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 635,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.starting_mult,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
                local final_mod = card.ability.extra.mult
                card.ability.extra.mult = card.ability.extra.mult * 2
                return {
                    mult = final_mod,
                    card = context.other_card
                }
            end
        end
        if context.end_of_round and not context.repetition and not context.individual then
            card.ability.extra.mult = card.ability.extra.starting_mult
        end
    end
}