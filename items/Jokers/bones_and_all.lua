SMODS.Joker {
    key = "bones_and_all",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            x_mult = 0.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 5, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 791177,
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
    pools, k_genre = {"Romance", "Fantasy", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.stacks,
                1 + (card.ability.extra.x_mult * card.ability.extra.stacks )
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind
        -- Destroy the joker to the right
        -- and gain stacks equal to its sell value
        -- Gives 1x + 0.25x per stack, and halves stacks when triggered
        if context.setting_blind then
            local _mypos = nil
            for _index, _joker in ipairs(G.jokers.cards) do
                if card == _joker then
                    _mypos = _index
                    break
                end
            end

            if G.jokers.cards and G.jokers.cards[_mypos + 1] and
            not SMODS.is_eternal(G.jokers.cards[_mypos + 1], {kino_bones_and_all = true, joker = true}) and 
            not G.jokers.cards[_mypos + 1].getting_sliced then
               local _target = G.jokers.cards[_mypos + 1]
               card.ability.extra.stacks = card.ability.extra.stacks + _target.sell_cost 

                G.E_MANAGER:add_event(Event({func = function()
                    (context.blueprint_card or card):juice_up(0.8, 0.8)
                    _target:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
        end

        if context.joker_main then
            local _xmult = 1 + (card.ability.extra.stacks * card.ability.extra.x_mult)
            card.ability.extra.stacks = math.floor(card.ability.extra.stacks / 2)
            return {
                x_mult = _xmult
            }
        end
    end
}