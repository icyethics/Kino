SMODS.Joker {
    key = "die_hard_1",
    order = 287,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 4, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 562,
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
    pools, k_genre = {"Action"},
    enhancement_gate = 'm_kino_action',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain $3 for every action card played
        if context.after and context.scoring_hand and context.cardarea == G.jokers then
            local _payout = 0
            for _, _pcard in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(_pcard, 'm_kino_action') then
                    _payout = _payout + card.ability.extra.money
                end
            end
        
            return {
                dollars = _payout
            }
        end
    end
}