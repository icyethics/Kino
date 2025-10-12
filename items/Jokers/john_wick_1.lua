SMODS.Joker {
    key = "john_wick_1",
    order = 286,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            bullet_count_non = 0,
            bullet_increase = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 3, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 245891,
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
    k_genre = {"Action"},
    enhancement_gate = "m_kino_action",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bullet_count_non,
                card.ability.extra.bullet_increase
            }
        }
    end,
    calculate = function(self, card, context)
        -- Has 1 bullet for each card destroyed this ante
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                card.ability.extra.bullet_count_non= card.ability.extra.bullet_count_non+ card.ability.extra.bullet_increase
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.bullet_count_non= 0
        end
    end
}