SMODS.Joker {
    key = "men_in_black_1",
    order = 247,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_xmult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 0, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 607,
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
    k_genre = {"Comedy", "Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.stacked_xmult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end

        if context.abduct and not context.blueprint then
            card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
        end
    end
}