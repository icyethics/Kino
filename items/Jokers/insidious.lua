SMODS.Joker {
    key = "insidious",
    order = 119,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 49018,
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_tarot_creation")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you open a booster pack, 1/4 chance to create a demon
        if context.open_booster  and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            -- if pseudorandom("insid") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_insid', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_tarot_creation") then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("Tarot",G.consumeables, nil, nil, nil, nil, "c_kino_demon", "insid")
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
            end
        end

    end
}