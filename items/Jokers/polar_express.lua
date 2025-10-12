SMODS.Joker {
    key = "polar_express",
    order = 143,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult_min = 1,
            mult_max = 20,
            chips_min = 5,
            chips_max = 100,
            used_discard = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 5255,
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
    k_genre = {"Christmas", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_min,
                card.ability.extra.mult_max,
                card.ability.extra.chips_min,
                card.ability.extra.chips_max
            }
        }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            card.ability.extra.used_discard = false
        end

        if context.pre_discard then
            card.ability.extra.used_discard = true
        end

        if context.joker_main then

            if card.ability.extra.used_discard then
                card.ability.extra.used_discard = false
                return {
                    card = card,
                    message = localize('k_polar_express_bad'),
                    colour = G.C.BLACK    
                }
            else
                card.ability.extra.used_discard = false
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_polar_express_good'), colour = G.C.YELLOW})
                return {
                    chips = pseudorandom("plr", card.ability.extra.chips_min, card.ability.extra.chips_max),
                    mult = pseudorandom("plr", card.ability.extra.mult_min, card.ability.extra.mult_max)
                }
            end
        end
        
    end
}