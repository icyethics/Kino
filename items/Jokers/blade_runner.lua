SMODS.Joker {
    key = "blade_runner",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_9",
    pos = { x = 3, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 78,
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
    pools, k_genre = {"Sci-fi", "Mystery"},
    enhancement_gate = "m_kino_sci_fi",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_sci_fi
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a straight, upgrade every sci-fi card in your deck
        if context.before and context.scoring_hand and next(context.poker_hands['Straight']) then
            for _, _card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(_card, "m_kino_sci_fi") then
                    _card.config.center:upgrade(_card)
                end
            end
        end 
    end
}