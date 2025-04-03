SMODS.Joker {
    key = "popeye",
    order = 229,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            powerboost = 2,
            right_joker = nil
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 0, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11335,
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
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.powerboost
            }
        }
    end,
    calculate = function(self, card, context)
        -- The joker to the right is 2x as strong
    end,
    update = function(self, card, dt)
        local _mypos =  nil
        for _, _joker in ipairs(G.jokers.cards) do
            if _joker == card then
                _mypos = _
                if G.jokers.cards[_ + 1] and
                G.jokers.cards[_mypos + 1] ~= card.ability.extra.right_joker then
                    card.ability.extra.right_joker:set_multiplication_bonus(card.ability.extra.right_joker, "popeye", 1)
                    card.ability.extra.right_joker = G.jokers.cards[_ + 1]
                    card.ability.extra.right_joker:set_multiplication_bonus(card.ability.extra.right_joker, "popeye", card.ability.extra.powerboost)
                end
                break
            end
        end
    end
}