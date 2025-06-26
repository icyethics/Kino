SMODS.Joker {
    key = "ex_machina",
    order = 84,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 264660,
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
    pools, k_genre = {"Sci-fi"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a single Sci-fi card, upgrade it once for each remaining hand
        if context.before and #context.full_hand == 1 then
            if SMODS.has_enhancement(context.full_hand[1], "m_kino_sci_fi") then
                context.full_hand[1].config.center:upgrade(context.full_hand[1], (G.GAME.current_round.hands_left * card.ability.extra.factor))
                -- SMODS.calculate_context({sci_fi_upgrade = true, sci_fi_upgrade_target = context.full_hand[1], kino_sci_fi_upgrade_count = (G.GAME.current_round.hands_left * card.ability.extra.factor)})
                -- SMODS.calculate_context({sci_fi_upgrade = true, kino_sci_fi_upgrade_count = (G.GAME.current_round.hands_left * card.ability.extra.factor)})
            end
        end
    end
}