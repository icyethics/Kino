SMODS.Joker {
    key = "breakfast_club",
    order = 19,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            base_mult = 1,
            threshold = 5,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 3},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2108,
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
    k_genre = {"Comedy", "Drama", "Romance"},
    loc_vars = function(self, info_queue, card)
        local _suit_count = 0 
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:is_suit("Clubs") then
                    _suit_count = _suit_count + 1
                end
            end
        end

        local _doubling = math.floor(_suit_count / card.ability.extra.threshold)

        local _final_mult = card.ability.extra.base_mult * (2 ^ _doubling)
        return {
            vars = {
                _final_mult,
                card.ability.extra.threshold,
                _suit_count,
            }
        }
    end,
    calculate = function(self, card, context)
        -- +1 Mult, doubles for every 6 [SUIT] cards in your deck
        if context.joker_main then
            local _suit_count = 0 
            for k, v in pairs(G.playing_cards) do
                if v:is_suit("Clubs") then
                    _suit_count = _suit_count + 1
                end
            end

            local _doubling = math.floor(_suit_count / card.ability.extra.threshold)

            local _final_mult = card.ability.extra.base_mult * (2 ^ _doubling)

            return {
                mult = _final_mult
            }
        end
    end
}