SMODS.Joker {
    key = "killer_klowns",
    order = 216,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 1,
            cost_non = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 5, y = 5},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 16296,
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
    pools, k_genre = {"Horror", "Comedy", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {    
            vars = {
                card.ability.extra.cost_non / card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            local destructable_jokers = {}
            local _planets_created = 0
            local _sellvalue = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and 
                -- not G.jokers.cards[i].ability.eternal and 
                not SMODS.is_eternal(G.jokers.cards[i], {kino_killer_klowns = true, joker = true}) and
                not G.jokers.cards[i].getting_sliced then 
                    destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] 
                end
            end
            local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('klowns')) or nil
            if joker_to_destroy and not (context.blueprint_card or card).getting_sliced then 
                joker_to_destroy.getting_sliced = true

                -- Grab rarity and convert it to a num
                -- _rarity = joker_to_destroy.config.center.rarity

                -- if _rarity == 'Common' then
                --     _rarity = 1
                -- elseif _rarity == 'Uncommon' then
                --     _rarity = 2
                -- elseif _rarity == 'Rare' then
                --     _rarity = 3
                -- elseif _rarity == 'Legendary' then
                --     _rarity = 4
                -- end
                -- found rarity
                _sellvalue = joker_to_destroy.sell_cost
                _planets_created = math.max(_sellvalue % (card.ability.extra.cost_non / card.ability.extra.factor), 1)
                
                
                G.E_MANAGER:add_event(Event({func = function()
                    (context.blueprint_card or card):juice_up(0.8, 0.8)
                    joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
            if not (context.blueprint_card or card).getting_sliced then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_klowns'), colour = G.C.MULT})
            end
            for i = 1, _planets_created do
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _card = create_card("Planet",G.consumeables, nil, nil, nil, nil, nil, "klowns")
                        _card:set_edition({negative = true}, true)
                        _card:add_to_deck()
                        G.consumeables:emplace(_card) 
                        return true
                    end}))
            end
        end
    end
}