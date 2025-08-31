SMODS.Joker {
    key = "50_first_dates",
    order = 151,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1824,
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
    pools, k_genre = {"Romance", "Comedy"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_romance
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- Romance cards trigger twice
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if SMODS.has_enhancement(context.other_card, "m_kino_romance") then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
    end
}