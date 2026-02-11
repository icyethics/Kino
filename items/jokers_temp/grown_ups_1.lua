SMODS.Joker {
    key = "grown_ups_1",
    order = 246,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 5, y = 5},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 38365,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local _highest_rank = 0
            local _chips = 0
            for _, _card in ipairs(context.scoring_hand) do
                if _card:get_id() > _highest_rank then
                    _highest_rank = _card:get_id()
                    _chips = _card.base.nominal + _card.ability.perma_bonus
                end
            end

            return {
                chips = _chips
            }
        end
    end
}