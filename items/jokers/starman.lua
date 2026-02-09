SMODS.Joker {
    key = "starman",
    order = 168,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1,
            match_made = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9663,
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
    k_genre = {"Romance", "Sci-fi"},
    enhancement_gate = "m_kino_romance",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.match_made then
            card.ability.extra.match_made = true
        end

        if context.joker_main and card.ability.extra.match_made then
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible then
                    upgrade_hand(card, v, 0, card.ability.extra.mult, 0, 0, true)
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_upgrade_ex'), colour = G.C.MULT})
                end
            end
            card.ability.extra.match_made = false
        end
    end
}