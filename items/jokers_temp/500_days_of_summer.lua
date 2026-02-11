SMODS.Joker {
    key = "500_days_of_summer",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            heartache = 5,
            stacked_mult = 0,
            a_mult = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 1, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 19913,
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
    k_genre = {"Drama", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.current_round.summer_card and G.GAME.current_round.summer_card.rank or "2",
                card.ability.extra.heartache,
                card.ability.extra.a_mult,
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever a [Rank] is unscored, put 5 Heartache counters on it. 
        -- Gain +1 mult whenever a Heartache Counter is removed

        if context.individual and context.cardarea == "unscored" then
            if context.other_card:get_id() == G.GAME.current_round.summer_card.id then
               context.other_card:bb_counter_apply("counter_kino_heartbreak", card.ability.extra.heartache) 
            end
        end

        if context.bb_counter_incremented and context.counter_type == G.P_COUNTERS.counter_kino_heartbreak and context.number < 0 then
            local _multgain = card.ability.extra.a_mult * (context.number * -1)
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + _multgain
            card:juice_up(0.8, 0.5)
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_heartache_stack'), colour = G.C.KINO.HEARTACHE })
        end

        if context.end_of_round and not context.repetition and not context.individual then
            
            local _valid_ranks = {}

            for _index, _pcard in ipairs(G.playing_cards) do
                local _id = tostring(_pcard:get_id())
                _valid_ranks[_id] = true
            end

            return {
                message = localize("k_reset")
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].bb_counter_application and
                G.PROFILES[G.SETTINGS.profile].bb_counter_application.counter_kino_heartbreak and 
                G.PROFILES[G.SETTINGS.profile].bb_counter_application.counter_kino_heartbreak.count or 0,
                20 
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'bb_counters_applied' then
            if G.PROFILES[G.SETTINGS.profile].bb_counter_application and
             G.PROFILES[G.SETTINGS.profile].bb_counter_application.counter_kino_heartbreak and 
             G.PROFILES[G.SETTINGS.profile].bb_counter_application.counter_kino_heartbreak.count and 
             G.PROFILES[G.SETTINGS.profile].bb_counter_application.counter_kino_heartbreak.count >= 20 then
                unlock_card(self)
            end
        end
    end,
}

function Kino.reset_summer_rank()
    G.GAME.current_round.summer_card = {rank = 'Ace', id = 14}
    local valid_summer_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(v) then
            valid_summer_cards[#valid_summer_cards+1] = v
        end
    end
    if valid_summer_cards[1] then 
        local summer_card = pseudorandom_element(valid_summer_cards, pseudoseed('mail'..G.GAME.round_resets.ante))
        G.GAME.current_round.summer_card.rank = summer_card.base.value
        G.GAME.current_round.summer_card.id = summer_card.base.id
    end
end