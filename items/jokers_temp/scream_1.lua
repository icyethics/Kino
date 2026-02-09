SMODS.Joker {
    key = "scream_1",
    order = 113,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 4232,
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
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain +2 mult for every Horror joker you have at the end of a blind
        -- Lose money equal to this joker's mult when you sell it.
        -- if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
        --     for i, v in ipairs(G.jokers.cards) do
        --         if is_genre(v, "Horror") then
        --             card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
        --             card.ability.extra_value = card.ability.extra_value - card.ability.extra.a_mult
        --             card:set_cost()
        --         end
        --     end
        -- end

        -- if context.joker_main then
        --     return {
        --         mult = card.ability.extra.stacked_mult
        --     }
        -- end
        if context.post_trigger and context.cardarea == G.jokers and
        not context.other_context.destroying_card 
        and not context.other_context.post_trigger
        and is_genre(context.other_card, "Horror") then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _tally = 0
            for i, _joker in ipairs(G.jokers.cards) do
                if is_genre(_joker, "Horror") then
                    _tally = _tally + 1
                end
            end

            if _tally >= 5 then
                unlock_card(self)
            end
        end
    end,
}