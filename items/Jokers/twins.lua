SMODS.Joker {
    key = "twins",
    order = 70,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 25,
            mult = 25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9493,
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
    pools, k_genre = {"Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- if your hand contains no more than 2 cards, gain 30 chips and 30 mult
        if context.joker_main and context.full_hand and #context.full_hand == 2 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}