SMODS.Joker {
    key = "paul",
    order = 259 ,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            powerboost = 0.5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_9",
    pos = { x = 0, y = 1},
    cost = 8,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 39513,
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
    pools, k_genre = {"Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.powerboost * 100
            }
        }
    end,
    calculate = function(self, card, context)
        -- Sci-fi jokers are 50% stronger
        if context.card_added then
            -- and context.card.set == "Joker" 
            for _, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center.key ~= 'j_kino_paul' and is_genre(_joker, "Sci-fi") then
                    _joker:set_multiplication_bonus(_joker, "paul", 1 + card.ability.extra.powerboost)
                end
            end
        end 
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.jokers then
            for _, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center.key ~= 'j_kino_paul' and is_genre(_joker, "Sci-fi") then
                    _joker:set_multiplication_bonus(_joker, "paul", 1 + card.ability.extra.powerboost)
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
            local _mypos =  nil
            for _, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center.key ~= 'j_kino_paul' and is_genre(_joker, "Sci-fi") then
                    _joker:set_multiplication_bonus(_joker, "paul", 1)
                end
            end
        end
	end
}