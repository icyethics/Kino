SMODS.Joker {
    key = "home_alone_1",
    order = 28,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 5},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 771,
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
    pools, k_genre = {"Christmas", "Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a high card, add its chips to this joker
        if context.individual and context.cardarea == G.play and
        context.scoring_name == "High Card" and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + context.other_card.base.nominal
            return {
                message = localize('k_upgrade_ex'),
                card = card,
                colour = G.C.CHIPS
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                card = card
            }

        end
    end
}