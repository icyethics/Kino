SMODS.Joker {
    key = "alien_3",
    order = 73,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            will_trigger = true
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8077,
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
    pools, k_genre = {"Sci-fi", "Action"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.debuff then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_lv426
        return {
            vars = {
                card.ability.extra.will_trigger
            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play a hand with only debuffed cards
        -- Create a LV426

        if context.before and not context.repetition and not context.blueprint then

            for i = 1, #context.full_hand do
                if context.full_hand[i].debuff then
                    card.ability.extra.will_trigger = true
                else 
                    card.ability.extra.will_trigger = false
                    break
                end
            end
        end

        if context.after and card.ability.extra.will_trigger and
        #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = create_card("Planet",G.consumeables, nil, nil, nil, nil, "c_kino_lv426", "alien")
                    card:add_to_deck()
                    G.consumeables:emplace(card) 
                    return true
                end}))
        end
    end
}