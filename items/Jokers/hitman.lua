SMODS.Joker {
    key = "hitman",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 2
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 5, y = 1},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 974635,
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
    pools, k_genre = {"Crime", "Romance", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local _mypos = nil
            for _index, _joker in ipairs(G.jokers.cards) do
                if card == _joker then
                    _mypos = _index
                    break
                end
            end

            if G.jokers.cards and G.jokers.cards[_mypos + 1] and
            not SMODS.is_eternal(G.jokers.cards[_mypos + 1], {kino_hitman = true, joker = true}) and 
            not G.jokers.cards[_mypos + 1].getting_sliced then
               local _target = G.jokers.cards[_mypos + 1]
               local _value = _target.sell_cost * card.ability.extra.factor

                G.E_MANAGER:add_event(Event({func = function()
                    (context.blueprint_card or card):juice_up(0.8, 0.8)
                    _target:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))

                return {
                    dollars = _value
                }
            end
        end
    end
}