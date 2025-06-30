SMODS.Joker {
    key = "paulblart_1",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 30,
            a_charge = 3,
            stacks = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 14560,
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
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.a_charge,
                card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.stacks <= 0 then
                return {
                    message = localize("k_kino_paulblart_1")
                }
            end

            if not context.blueprint and not context.repetition then
                card.ability.extra.stacks = card.ability.extra.stacks - 1
            end
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.post_confection_used and not context.blueprint then
            card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_charge
        end
    end
}