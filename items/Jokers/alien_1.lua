SMODS.Joker {
    key = "alien_1",
    order = 117,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance_cur = 1,
            a_chance = 1,
            chance = 100,
            x_mult = 1.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 348,
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
    pools, k_genre = {"Horror", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.chance_cur, card.ability.extra.chance, "kino_joker_destruction")
          
        return {
            vars = {
                new_numerator,
                card.ability.extra.a_chance,
                new_denominator,
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Each scored card gives x1.25.
        -- After each hand, 1/100 chance to destroy all jokers. Each scored card increases this by 1.
        -- Reset chance when you sell a joker.
        if context.individual and context.cardarea == G.play then
            card.ability.extra.chance_cur = card.ability.extra.chance_cur + card.ability.extra.a_chance
            return {
                x_mult = card.ability.extra.x_mult,
                card = context.other_card
            }
        end

        if context.after then
            if SMODS.pseudorandom_probability(card, 'kino_alien1', card.ability.extra.chance_cur, card.ability.extra.chance, "kino_joker_destruction") then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and
                    -- not G.jokers.cards[i].ability.eternal and
                    not SMODS.is_eternal(G.jokers.cards[i], {kino_alien_1 = true, joker = true}) and
                    not G.jokers.cards[i].getting_sliced then 
                            G.jokers.cards[i].getting_sliced = true
                            G.E_MANAGER:add_event(Event({func = function()
                                (context.blueprint_card or card):juice_up(0.8, 0.8)
                                G.jokers.cards[i]:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                end
            end
        end

        if context.selling_card and context.card.config.center.set == 'Joker' then
            card.ability.extra.chance_cur = 1
        end
    end
}