SMODS.Joker {
    key = "snow_white_1",
    order = 172,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_count = 0,
            mult = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 408,
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
    pools, k_genre = {"Romance", "Fantasy", "Animation"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.stacked_count
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a card lower than 5, gain a stack
        -- When you play a Queen, consume each stack to gain +3 mult per stack
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() <= 2 then
                card.ability.extra.stacked_count = card.ability.extra.stacked_count + 1
                return {
                    message = localize('k_upgrade_ex'),
                    card = card,
                    colour = G.C.MULT
                }
            end

            if context.other_card:get_id() == 12 then
                local _mult = card.ability.extra.stacked_count * card.ability.extra.mult
                return {
                    mult = _mult
                }
            end
        end
    end
}