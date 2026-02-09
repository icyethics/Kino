SMODS.Joker {
    key = "shopaholic",
    order = 33,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 0.25,
            stacked_x_mult = 1,
            money_spend_non = 5,
            cur_spend_non = 0,
            threshold = 5

        }
    },
    rarity = 3,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 0},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 20048,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_x_mult,
                card.ability.extra.money_spend_non,
                card.ability.extra.cur_spend_non,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        if context.kino_ease_dollars and to_big(context.kino_ease_dollars) < to_big(0) and not context.blueprint then
            local pos_spend = -1 * context.kino_ease_dollars
            card.ability.extra.cur_spend_non = card.ability.extra.cur_spend_non + pos_spend
            
            local upgraded = false
            -- Checks if enough money was spend
            while to_big(card.ability.extra.cur_spend_non) >= to_big(card.ability.extra.threshold) do
                upgraded = true
                
                -- upgrades xmult
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
                
                -- Lowers the counter
                card.ability.extra.cur_spend_non = card.ability.extra.cur_spend_non - card.ability.extra.threshold

                -- sets the new treshold
                card.ability.extra.threshold = card.ability.extra.threshold + card.ability.extra.money_spend_non 
            end

            if upgraded then
                return {
                    message = localize('k_upgrade_ex'),
                    card = card
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult,
                message = localize{type='variable', key = 'a_xmult', vars = {card.ability.extra.stacked_x_mult}},
            }
        end
    end
}