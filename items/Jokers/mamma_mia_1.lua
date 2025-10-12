SMODS.Joker {
    key = "mamma_mia_1",
    order = 264,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            limit_non = 3,
            mult = 20
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 5, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11631,
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
    k_genre = {"Musical", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.limit_non,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain +20 mult if your scored hand contains at least 3 Hearts
        if context.joker_main then
            local _count = 0
            for _, _pcard in ipairs(context.scoring_hand) do
                if _pcard:is_suit("Hearts") then
                    _count = _count + 1
                end
            end

            if _count >= card.ability.extra.limit_non then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}