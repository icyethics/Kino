SMODS.Joker {
    key = "zardoz",
    order = 208,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 3, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 4923,
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
    k_genre = {"Sci-fi", "Adventure", "Action"},
    enhancement_gate = "m_stone",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Stone cards give X0.1 for each card you've destroyed this ante
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
            end
        end

        if context.individual and context.cardarea == G.play and 
        context.other_card.config.center == G.P_CENTERS.m_stone then
            return {
                x_mult = card.ability.extra.stacked_x_mult,
                card = context.other_card
            }
        end
    end
}