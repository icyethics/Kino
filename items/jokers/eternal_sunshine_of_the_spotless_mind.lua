SMODS.Joker {
    key = "eternal_sunshine_of_the_spotless_mind",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            heartache = 1,
            stacked_xmult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 2, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 38,
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
    k_genre = {"Drama", "Sci-fi"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.heartache,
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_xmult,
            }
        }
    end,
    calculate = function(self, card, context)

        
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                local _compID = context.removed[i]:get_id()
                for _index, _pcard in ipairs(G.deck.cards) do
                    if _pcard:get_id() == _compID then
                        _pcard:bb_counter_apply("counter_kino_heartbreak", card.ability.extra.heartache)     
                    end
                end
            end
        end

        if context.bb_counter_incremented and context.counter_type == G.P_COUNTERS.counter_kino_heartbreak and context.number < 0 then
            local _chipgain = card.ability.extra.a_xmult * (context.number * -1)
            card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + _chipgain
            card:juice_up(0.8, 0.5)
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_heartache_stack'), colour = G.C.KINO.HEARTACHE })
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end
    end
}