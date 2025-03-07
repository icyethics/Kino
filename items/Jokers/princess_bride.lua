SMODS.Joker {
    key = "princess_bride",
    order = 64,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_drawn = 2
        }
    },
    rarity = 3,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 4},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2493,
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
    pools, k_genre = {"Fantasy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_drawn
            }
        }
    end,
    calculate = function(self, card, context)
        -- If your played hand contains a hearts, draw 2 cards.

        if context.before and context.cardarea == G.jokers then
            local _isHearts = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then
                    _isHearts = true
                    break
                end
            end

            if _isHearts then
                G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
            end
        end

    end
}