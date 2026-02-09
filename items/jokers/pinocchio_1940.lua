SMODS.Joker {
    key = "pinocchio_1940",
    order = 128,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 10
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10895,
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
    k_genre = {"Fantasy", "Musical", "Animation"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- unmodified cards give +5 chips when held in hand
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.BLUE,
                    card = card,
                }
            end

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