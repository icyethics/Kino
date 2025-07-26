SMODS.Joker {
    key = "arrival",
    order = 221,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            codex = {},
            codex_solve = Kino.get_dummy_codex(),
            codex_lastplayed = Kino.get_dummy_codex(),
            codex_type = 'rank',
            codex_length = 5,
            solved = false,
            decrease = 2,
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 4, y = 0},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    kino_joker = {
        id = 329865,
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
    -- get_weight_mod = function()
    --     return 1000
    -- end,
    k_genre = {"Sci-fi"},
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
                card.ability.extra.decrease
            },
            main_end = _codexreturn
        }
    end,
    calculate = function(self, card, context)
        -- if the codex is solved, go back 2 antes and destroy this joker

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
                ease_ante(-card.ability.extra.decrease)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.decrease

                if not context.blueprint and not context.retrigger then
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        card:juice_up(0.8, 0.8)
                        card.getting_sliced = true
                        card:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                end
            end
        end
        
    end,
}