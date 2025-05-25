SMODS.Joker {
    key = "clown",
    order = 165,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 112454,
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
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local num = 0
            for i, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center == G.P_CENTERS.j_kino_clown then
                    num = num + 1
                end
            end
            return {
                mult = card.ability.extra.mult * num
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and (G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)) > 0 then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = create_card('Joker', G.jokers, nil, 0, nil, nil, "j_kino_clown", 'clown')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                end}))   
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE}) 
        end
    end
}