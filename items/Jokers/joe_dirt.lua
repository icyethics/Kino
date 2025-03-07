SMODS.Joker {
    key = "joe_dirt",
    order = 28,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 0,
            a_chips = 10
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 4},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10956,
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
    pools, k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gains 10 chips when you discard a spade
        if context.discard and not context.other_card.debuff and context.other_card:is_suit("Spades") then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.a_chips

            return {
                message = localize('k_upgrade_ex'),
                card = card,
                colour = G.C.CHIPS
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                message = localize({ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips}})
            }
        end

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.chips = 0
        end
    end
}