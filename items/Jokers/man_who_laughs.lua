SMODS.Joker {
    key = "man_who_laughs",
    order = 130,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 0.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 27517,
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
    pools, k_genre = {"Romance", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_xmult,
                math.max(((G.jokers and G.jokers.cards and #G.jokers.cards or 0) - 1) * card.ability.extra.a_xmult + 1, 1)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = 1 + ((G.jokers and G.jokers.cards and #G.jokers.cards or 0) - 1) * card.ability.extra.a_xmult
            }
        end
    end
}