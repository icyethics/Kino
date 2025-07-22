SMODS.Joker {
    key = "voyage_dans_le_lune",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 4, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 775,
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
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_planet_creation")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- 
        if context.open_booster and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            -- if pseudorandom('voyage') < (card.ability.extra.cur_chance ) / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_voyage_dans_le_lune', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_planet_creation") then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local card = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'lune')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.PURPLE})
            end
        end
    end
}