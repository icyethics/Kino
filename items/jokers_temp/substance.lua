SMODS.Joker {
    key = "substance",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            counters_applied = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 4, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 933260,
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
    k_genre = {"Horror", "Comedy"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_COUNTERS.counter_mult
        return {
            vars = {
                card.ability.extra.counters_applied,

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you draw a face card, put +1 Mult counter on it.
        -- Increase this by 1 whenever a Queen is transformed
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                if context.hand_drawn[i]:is_face() then
                    card.ability.extra.cards_drawn_non = 0
                    context.hand_drawn[i]:bb_counter_apply("counter_mult", card.ability.extra.counters_applied)
                    return {
                        message = localize("k_kino_mult_counter"),
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.change_rank and context.old_rank == 12 then
            card.ability.extra.counters_applied = card.ability.extra.counters_applied + 1
        end
    end
}