SMODS.Joker {
    key = "se7en",
    order = 74,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 7,
            sevens_trig_non = 0,
            sevens_trig_cap_non = 49
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 807,
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
        -- 7s give +7 mult

        if context.individual and context.other_card:get_id() == 7 and context.cardarea == G.play then
            card.ability.extra.sevens_trig_non = card.ability.extra.sevens_trig_non + 1

            if card.ability.extra.sevens_trig_non == card.ability.extra.sevens_trig_cap_non then
                card.ability.extra.sevens_trig_non = 0
                return {
                    x_mult = card.ability.extra.mult
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}