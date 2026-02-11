SMODS.Joker {
    key = "pinocchio_2022",
    order = 127,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 20
        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 3},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 532639,
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
    k_genre = {"Fantasy", "Musical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- unmodified cards give +20 chips when scored
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.c_base and
            context.other_card.seal == nil and
            context.other_card.edition == nil then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}