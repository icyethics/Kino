SMODS.Joker {
    key = "kung_fu_panda_1",
    order = 244,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 100
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 3, y = 5},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9502,
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
    k_genre = {"Action", "Animation", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, _card in ipairs(context.scoring_hand) do
                if _card:is_suit("Spades") then
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
        end
    end
}