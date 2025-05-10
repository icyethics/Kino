SMODS.Joker {
    key = "as_above",
    order = 245,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 0,
            a_chips = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 4, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 256274,
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
                card.ability.extra.chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and
        not context.other_card.debuff 
        and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.a_chips
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round and not context.blueprint and not context.individual then
            card.ability.extra.chips = 0
            return {
                message = localize('k_reset'),
                colour = G.C.BLUE
            }
        end
    end
}