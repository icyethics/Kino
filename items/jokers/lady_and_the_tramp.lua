SMODS.Joker {
    key = "lady_and_the_tramp",
    order = 170,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10340,
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
    k_genre = {"Romance", "Animation"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _lowest = 14
            local _highest = 0
            for _, card in ipairs(context.scoring_hand) do
                if not card.config.center.replace_base_card then
                    if _lowest >= card.base.id then
                        _lowest = card.base.nominal
                    end

                    if _highest <= card.base.id then
                        _highest = card.base.nominal
                    end
                end
            end

            local _dif = _highest - _lowest
            local _chips = _dif * card.ability.extra.a_chips

            return {
                chips = _chips
            }
        end
    end
}