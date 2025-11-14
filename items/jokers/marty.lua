SMODS.Joker {
    key = "marty",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            heartache = 1,
            stacked_chips = 0,
            a_chips = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 0, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 15919,
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
                card.ability.extra.heartache,
                card.ability.extra.a_chips,
                card.ability.extra.stacked_chips,
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever a card is unscored, give it 1 Heartache counter. 
        -- When it scores, remove all Heartache counters, 
        -- and gain +5 chips per counter removed.

        if context.individual and context.cardarea == "unscored" then
            context.other_card:bb_counter_apply("counter_kino_heartbreak", card.ability.extra.heartache)
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
    end
}