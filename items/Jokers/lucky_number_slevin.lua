SMODS.Joker {
    key = "lucky_number_slevin",
    order = 141,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            increase_amount_non = 1,
            main_eval = false
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 5},
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 186,
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
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        local _seven_count = 0
        if G.hand and G.hand.cards then
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:get_id() == 7 then
                    _seven_count = _seven_count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.increase_amount_non,
                _seven_count
            }
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint and not context.retrigger then
            local _seven_count = 0
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:get_id() == 7 then
                    _seven_count = _seven_count + 1
                end
            end

            return {
                numerator = context.numerator + _seven_count
            }
        end
    end
}