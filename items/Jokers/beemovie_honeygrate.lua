if Cryptid and Talisman then
SMODS.Joker {
    key = "beemovie_honeygrate",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            emult = 1,
            emult_gain = 0.05
        }
    },
    rarity = 1,
    atlas = "kino_cryptid_consumables",
    pos = { x = 0, y = 5},
    cost = 0,
    no_collection = true,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    in_pool = function(self, args)
        return false
    end,
    -- pools, k_genre = {"Animation", "Comedy", "Family"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                1 + (G.GAME.beemovie_honeygrates_removed or 0) * card.ability.extra.emult_gain,
                card.ability.extra.emult_gain,
                (G.GAME.beemovie_honeygrates_removed or 0)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                e_mult = 1 + (G.GAME.beemovie_honeygrates_removed or 0) * card.ability.extra.emult_gain,
            }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if from_debuff == true then return end
        G.GAME.beemovie_honeygrates_removed = (G.GAME.beemovie_honeygrates_removed or 0) + 1
    end
}
end