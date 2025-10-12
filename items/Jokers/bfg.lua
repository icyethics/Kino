SMODS.Joker {
    key = "bfg",
    order = 97,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 267935,
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
    k_genre = {"Fantasy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                G.GAME.round_scores["hand"].amt,
                (card.ability.extra.a_mult * G.GAME.current_round.beaten_run_high) or 0
            }
        }
    end,
    calculate = function(self, card, context)
        -- +1 mult for every time you've played a hand that set a new high score this run.
        if context.joker_main then
            return {
                mult = card.ability.extra.a_mult * G.GAME.current_round.beaten_run_high
            }
        end
    end
}