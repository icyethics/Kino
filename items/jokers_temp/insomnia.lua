SMODS.Joker {
    key = "insomnia",
    order = 101,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 320,
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
    k_genre = {"Crime", "Thriller"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- double your hand size. You do not draw cards
        if context.setting_blind and not context.getting_sliced then
            G.hand:change_size(G.hand.config.card_limit)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + G.hand.config.card_limit
        end

        if context.insomnia_awake then
            card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_insomnia'), colour = G.C.BLACK })
        end
    end
}