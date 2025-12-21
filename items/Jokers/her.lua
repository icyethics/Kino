SMODS.Joker {
    key = "her",
    order = 239,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            heartache = 1,
            stacked_chips = 0,
            a_chips = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 4, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 152601,
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
    k_genre = {"Sci-fi", "Romance"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_sci_fi") or
                SMODS.has_enhancement(v, "m_kino_romance") then

                    enhancement_gate = true
                    break
                end
            end
        end
        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.heartache,
                card.ability.extra.a_chips,
                card.ability.extra.stacked_chips,
            }
        }
    end,
    calculate = function(self, card, context)

        
        if context.upgrading_sci_fi_card and not context.blueprint then

            for _index, _pcard in ipairs(G.deck.cards) do
                if SMODS.has_enhancement(_pcard, "m_kino_sci_fi") then
                    _pcard:bb_counter_apply("counter_kino_heartbreak", card.ability.extra.heartache)     
                end
            end
        end

        if context.bb_counter_incremented and context.counter_type == G.P_COUNTERS.counter_kino_heartbreak and context.number < 0 then
            local _chipgain = card.ability.extra.a_chips * (context.number * -1)
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + _chipgain
            card:juice_up(0.8, 0.5)
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_heartache_stack'), colour = G.C.KINO.HEARTACHE })
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
        if args.type == 'kino_heartbreak_sci_fi' then
            unlock_card(self)
        end
    end,
}