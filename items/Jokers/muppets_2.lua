SMODS.Joker {
    key = "muppets_2",
    order = 25,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            min_mult = -5,
            max_mult = 35
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
                card.ability.extra.min_mult,
                card.ability.extra.max_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        context.other_card:is_suit("Diamonds") then
            local mult = pseudorandom("muppets_2", card.ability.extra.min_mult, card.ability.extra.max_mult)
            return {
                mult = mult,
                card = context.other_card
            }
        end
    end
}