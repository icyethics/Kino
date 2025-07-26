SMODS.Joker {
    key = "oppenheimer",
    order = 108,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            codex = {},
            codex_solve = Kino.get_dummy_codex(),
            codex_lastplayed = Kino.get_dummy_codex(),
            codex_type = 'rank',
            codex_length = 5,
            solved = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 872585,
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
    pools, k_genre = {"Biopic", "Drama", "Historical"},

    loc_vars = function(self, info_queue, card)
        local _mainreturncodex = Kino.codex_ui("rank", card.ability.extra.codex_solve)
        local _lastplayedhand = Kino.last_hand_played_codex("rank", card.ability.extra.codex_lastplayed, true)
        local _codexreturn = {
        {
                n = G.UIT.C,
                config = {
                    align = 'cm',
                    colour = G.C.CLEAR,
                    padding = 0.01
                },
                nodes = {
                    _mainreturncodex,
                    _lastplayedhand
                }
            }
        }
        return {
            vars = {

            },
            main_end = _codexreturn
        }
    end,
    calculate = function(self, card, context)

        if context.joker_main then

            if #card.ability.extra.codex <= 0 then
                card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, 'arrival')
            end

            local result = false
            if not context.blueprint and not context.repetition then
                result, card.ability.extra.codex_solve, card.ability.extra.codex_lastplayed = Kino.compare_hand_to_codex(card, card.ability.extra.codex, context.full_hand, card.ability.extra.codex_solve, 'rank')
                if result == true then
                    card.ability.extra.solved = true
                end
            end

            if card.ability.extra.solved then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local _card = create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, "kino_oppie")
                            _card:add_to_deck()
                            G.consumeables:emplace(_card) 
                            return true
                        end}))
                        card:juice_up()
                        card_eval_status_text(context.blueprint_card or card, 
                        'extra', nil, nil, nil, {message = localize('kino_codex'), colour = G.C.CHIPS})                
                end
                card.ability.extra.solved = false
                card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, 'oppie')
            end
        end
    end
}