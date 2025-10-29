SMODS.Joker {
    key = "hellraiser_1",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            codex = {},
            codex_solve = Kino.get_dummy_codex(),
            codex_lastplayed = Kino.get_dummy_codex(),
            codex_type = 'rank',
            codex_length = 5,
            solved = false,
            lower_by = 10,
            stacks = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 3, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9003,
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
    k_genre = {"Horror"},

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
        -- On the hand you beat the codex:
        -- destroy either all scoring cards, or cards in hand
        -- and give enhancements, seals and editions to the other

        if context.joker_main then
            if #card.ability.extra.codex <= 0 then
                card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, 'hellraiser')
            end

            local result = false
            if not context.blueprint and not context.repetition then
                result, card.ability.extra.codex_solve, card.ability.extra.codex_lastplayed = Kino.compare_hand_to_codex(card, card.ability.extra.codex, context.full_hand, card.ability.extra.codex_solve, 'rank')
                if result == true then
                    card.ability.extra.solved = true
                end
            end

            if card.ability.extra.solved then

                card.ability.extra.solved = false
                card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil,'hellraiser')

                local _destroy_table = G.hand.cards
                local _enhance_table = context.full_hand
                if pseudorandom("coin_flip_kino") > 0.5 then
                    _destroy_table = context.full_hand
                    _enhance_table = G.hand.cards
                end

                for _, _pcard in ipairs(_destroy_table) do
                    _pcard.marked_by_hellraiser = true
                end

                for _, _pcard in ipairs(_enhance_table) do

                    G.E_MANAGER:add_event(Event({
                    func = function()
                        _pcard:flip()
                        local edition = poll_edition('kino_hellraiser', nil, true, true)
                        _pcard:set_edition(edition, true)

                        local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'kino_hellraiser'})
                        _pcard:set_ability(G.P_CENTERS[new_enhancement])

                        local new_seal = SMODS.poll_seal({guaranteed = true, key = 'kino_hellraiser'})
                        _pcard:set_seal(new_seal)
                        delay(0.2)
                        _pcard:flip()
                        return true
                    end}))

                end
            end
        end

        if context.destroying_card and context.destroying_card.marked_by_hellraiser then
            return { remove = true }
        end
        
    end,
}