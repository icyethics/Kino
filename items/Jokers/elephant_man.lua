SMODS.Joker {
    key = "elephant_man",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 10,
            mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 5, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1955,
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
    pools, k_genre = {"Drama", "Biopic"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                G.GAME.current_round.hands_played * card.ability.extra.chips,
                G.GAME.current_round.discards_used * card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gains +2 mult this round if you discard
        -- Gains +10 chips this round if you play a hand
        if context.joker_main then
            local _array = {}

            if G.GAME.current_round.hands_played > 0 then
                _array.chips = G.GAME.current_round.hands_played * card.ability.extra.chips
            end
            if G.GAME.current_round.discards_used > 0 then
                _array.mult = G.GAME.current_round.discards_used * card.ability.extra.mult
            end

            return _array
        end
    end
}