SMODS.Joker {
    key = "tron",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 1,
            threshold = 5,
            count_non = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 4, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 97,
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
    k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        -- When Sci-fi jokers have triggered 5 times, gain +1 mult
        if context.post_trigger and context.cardarea == G.jokers and
        not context.other_context.destroying_card 
        and not context.other_context.post_trigger
        and is_genre(context.other_card, "Sci-fi") then
            card.ability.extra.count_non = card.ability.extra.count_non + 1
            if card.ability.extra.count_non >= 5 then
                card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
                card.ability.extra.count_non = 0
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}