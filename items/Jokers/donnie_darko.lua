SMODS.Joker {
    key = "donnie_darko",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            debuff_counters_non = 5,
            retrigger_counters = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_9",
    pos = { x = 1, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 141,
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
    pools, k_genre = {"Drama", "Fantasy", "Mystery"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.debuff_counters_non,
                card.ability.extra.retrigger_counters
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and G.GAME.current_round.hands_played == 0 
        and context.scoring_hand and #context.scoring_hand == 2 then
            -- check if joker to the left
            local _target = nil
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker == card and _index > 1 then
                    _target = G.jokers.cards[_index - 1]
                end
            end

            for _index, _pcard in ipairs(context.scoring_hand) do
                if not context.blueprint and not context.retrigger then
                    -- Kino.change_counters(_pcard, "kino_stun", card.ability.extra.debuff_counters_non)
                    _pcard:bb_counter_apply("counter_stun", card.ability.extra.debuff_counters_non)
                end

                -- Kino.change_counters(_target, "kino_retrigger", card.ability.extra.retrigger_counters)
                _target:bb_counter_apply("counter_retrigger", card.ability.extra.retrigger_counters)
                
            end
        end
    end
}