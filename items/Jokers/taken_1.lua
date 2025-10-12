SMODS.Joker {
    key = "taken_1",
    order = 289,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 30
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8681,
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
    k_genre = {"Action", "Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _isqueen = false
            for _, _pcard in ipairs(G.hand.cards) do
                if _pcard:get_id() == 12 then
                    _isqueen = true
                end
            end

            if _isqueen then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}