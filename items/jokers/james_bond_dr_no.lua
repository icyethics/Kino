SMODS.Joker {
    key = "james_bond_dr_no",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            counters_applied = 3,
            cards_drawn_non = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 5, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 646,
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
    k_genre = {"Action", "Thriller"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_COUNTERS.counter_mult
        return {
            vars = {
                card.ability.extra.counters_applied,
                7 - card.ability.extra.cards_drawn_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- Put 5 Mult counters on every 7th card drawn
        if context.hand_drawn and not context.blueprint then
            for i = 1, #context.hand_drawn do
                card.ability.extra.cards_drawn_non = card.ability.extra.cards_drawn_non + 1
                if card.ability.extra.cards_drawn_non == 7 then
                    card.ability.extra.cards_drawn_non = 0
                    context.hand_drawn[i]:bb_counter_apply("counter_mult", card.ability.extra.counters_applied)
                    return {
                        message = localize("k_kino_james_bond_1"),
                        colour = G.C.MULT
                    }
                elseif card.ability.extra.cards_drawn_non == 6 then
                    local eval = function(card) return card.ability.extra.cards_drawn_non == 6 end
                    juice_card_until(card, eval, true)
                end
            end
        end
    end
}