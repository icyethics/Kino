SMODS.Joker {
    key = "blair_witch",
    order = 150,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance_cur = 0,
            chance = 100,
            a_chance = 5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 0},
    cost = 10,
    blueprint_compat = false,
    perishable_compat = false,
    eternal_compat = false,
    kino_joker = {
        id = 2667,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.chance_cur), card.ability.extra.chance, "kino_joker_destruction")
         
        return {
            vars = {
                new_numerator,
                new_denominator,
                card.ability.extra.a_chance
            }
        }
    end,
    calculate = function(self, card, context)
        -- Rerolls are free. Every time you reroll, increase the chance by 5 to destroy all current jokers.
        
        
        if context.reroll_shop and not context.blueprint then
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
		    calculate_reroll_cost(true)

            -- if pseudorandom("blair") < (card.ability.extra.chance_cur / card.ability.extra.chance) then
            if SMODS.pseudorandom_probability(card, 'kino_blair', (card.ability.extra.chance_cur), card.ability.extra.chance, "kino_joker_destruction") then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and 
                    -- not G.jokers.cards[i].ability.eternal and
                    not SMODS.is_eternal(G.jokers.cards[i], {kino_blair_witch = true, joker = true}) and 
                    not G.jokers.cards[i].getting_sliced then 
                            G.jokers.cards[i].getting_sliced = true
                            G.E_MANAGER:add_event(Event({func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                G.jokers.cards[i]:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                end

                if card.ability.extra.chance_cur >= 100 then
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        card:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                    return true
                end
            end

            card.ability.extra.chance_cur = card.ability.extra.chance_cur + card.ability.extra.a_chance
        end
    end,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
		calculate_reroll_cost(true)
	end,
    remove_from_deck = function(self, card, from_debuff)
		calculate_reroll_cost(true)
	end,
}