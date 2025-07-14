SMODS.Joker {
    key = "lost_in_translation",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 3, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a romance joker triggers, it gives +1 mult
        if context.post_trigger and context.cardarea == G.jokers and
        not context.other_context.destroying_card 
        and not context.other_context.post_trigger and
        G.STATE == G.STATES.HAND_PLAYED then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}