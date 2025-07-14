SMODS.Joker {
    key = "rush_hour",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 3,
            mult = 0.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 3, y = 0},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2109,
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
    pools, k_genre = {"Action", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When your hand contains a pair
        -- upgrade the hand with +3 chips for each scoring black suit
        -- and +0.5 mult for each scoring red suit
        if context.before and context.scoring_hand and next(context.poker_hands['Pair']) then
            local _hand = context.scoring_name
            local _chips = 0
            local _mult = 0

            for _index, _pcard in ipairs(context.scoring_hand) do
                if _pcard:is_suit("Hearts") or _pcard:is_suit("Diamonds") then
                    _mult = _mult + card.ability.extra.mult
                end
                if _pcard:is_suit("Spades") or _pcard:is_suit("Clubs") then
                    _chips = _chips + card.ability.extra.chips
                end
            end

            upgrade_hand(card, _hand, _chips, _mult)
        end
    end
}