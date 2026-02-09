SMODS.Joker {
    key = "always",
    order = 93,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            bonus = 10
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 3},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11352,
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
    k_genre = {"Romance", "Fantasy"},
    enhancement_gate = "m_kino_romance",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card is destroyed, upgrade every Romance card in your deck with +10 chips
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                for i, v in ipairs(G.playing_cards) do
                    if v.config.center == G.P_CENTERS.m_kino_romance then
                        v.ability.perma_bonus = v.ability.perma_bonus or 0
                        v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.bonus
                    end
                end
            end
        end
    end
}