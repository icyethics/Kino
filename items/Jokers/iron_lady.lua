SMODS.Joker {
    key = "iron_lady",
    order = 262,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 3, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 71688,
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
    k_genre = {"Drama", "Biopic"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, _pcard in ipairs(context.scoring_hand) do
                if _pcard:get_id() == 12 then
                    return {
                        x_mult = card.ability.extra.x_mult
                    }
                end
            end
        end
    end
}