SMODS.Joker {
    key = "pitch_black",
    order = 258,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 5, y = 0},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2787,
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
    k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and G.GAME.current_round.hands_left > 0 and context.cardarea == G.play then
                card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
        end

        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end

        if context.after and G.GAME.current_round.hands_left == 0 then
            if card.ability.extra.stacked_mult ~= 0 then
                card.ability.extra.stacked_mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            end
        end
    end
}