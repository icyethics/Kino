SMODS.Joker {
    key = "batmanvsuperman",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            powerboost = 1,
            boosted_cards = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 209112,
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
    pools = {["kino_batman"] = true}, 
    k_genre = {"Superhero", "Action", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.powerboost * 100
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss then
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker.ID ~= card.ID and kino_quality_check(_joker, "is_batman") then
                    card.ability.extra.boosted_cards[_joker.ID] = 1 + card.ability.extra.powerboost
                    _joker:set_multiplication_bonus(_joker, "batvsupe_" .. card.ID, 1 + card.ability.extra.powerboost)
                end
            end
        end
        
        if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
            for _index, _joker in ipairs(G.jokers.cards) do
                if card.ability.extra.boosted_cards[_joker.ID] then
                    _joker:set_multiplication_bonus(_joker, "batvsupe_" .. card.ID, 1, nil, card.ability.extra.boosted_cards[_joker.ID])
                end
            end
        end
    end
}