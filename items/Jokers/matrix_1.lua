SMODS.Joker {
    key = "matrix_1",
    order = 87,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 25,
            total = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 603,
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
    pools, k_genre = {"Sci-fi", "Action"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.total * card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- +10 chips for each sci-fi card in your deck. 
        if G.STAGE == G.STAGES.RUN then
            -- Check for sci-fi cards in your deck.
            local sci_count = 0
            for k, v in pairs(G.playing_cards) do
                if v.config.center == G.P_CENTERS.m_kino_sci_fi then
                    sci_count = sci_count + 1
                end
            end
            card.ability.extra.total = sci_count
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.total * card.ability.extra.chips
            }
        end
    end
}