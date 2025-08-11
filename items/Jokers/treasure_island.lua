SMODS.Joker {
    key = "treasure_island",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 1, y = 4},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 6646,
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
    pools, k_genre = {"Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        local _count = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                _count = _count + G.jokers.cards[i].sell_cost
            end
        end

        return {
            vars = {
                card.ability.extra.factor,
                _count
            }
        }
    end,
    calculate = function(self, card, context)
        
    end,
    calc_dollar_bonus = function(self, card)
        if G.GAME.blind.boss then
            local _count = 0
            for i = 1, #G.jokers.cards do
                _count = _count + G.jokers.cards[i].sell_cost
            end

            return _count * card.ability.extra.factor
        end
    end
}