SMODS.Joker {
    key = "number_23",
    order = 147,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 23
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 3594,
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
    k_genre = {"Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives +23 mult if the combined value of ranks played is 23
        if context.joker_main then
            local _tally = 0
            for i = 1, #context.full_hand do
                _tally = _tally + context.full_hand[i].base.nominal
            end

            if _tally == 23 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}