SMODS.Joker {
    key = "coco",
    order = 194,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_chips = 20,
            stacked_chips = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 354912,
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
    k_genre = {"Animation", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_chips,
                card.ability.extra.stacked_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain +20 chips when you use a Death
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == "Tarot" and context.consumeable.ability.name == "Death" then
                card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
                return {
                    message = localize('k_upgrade_ex'),
                    card = card,
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
    end
}