SMODS.Joker {
    key = "kindergarten_cop",
    order = 71,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 951,
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
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- X2 if your hand contains no cards with a rank above 5

        if context.joker_main then
            local _will_trig = true
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() > 5 then
                    if context.scoring_hand[i]:get_id() ~= 14 then
                        _will_trig = false
                        break
                    end
                end
            end

            if _will_trig then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end

    end
}