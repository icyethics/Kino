SMODS.Joker {
    key = "kiki_delivery",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            times_available_reset_num = 3,
            times_available_counter_non = 0,
            fee_non = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 0, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 16859,
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
    k_genre = {"Animation", "Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.times_available_reset_num,
                card.ability.extra.times_available_reset_num - card.ability.extra.times_available_counter_non,
                card.ability.extra.fee_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- The first three times you reroll each round,
        -- this takes $3 and adds a booster pack to the shop
        if context.kino_enter_shop then
            card.ability.extra.times_available_counter_non = 0
            local eval = function(card) 
                local _value = (card.ability.extra.times_available_counter_non < card.ability.extra.times_available_reset_num)
                local _location = true

                if G.GAME.blind.in_blind then
                    _location = false
                end

                local _return = true
                if _location == false or _value == false then
                    _return = false
                end
                return _return
            end
            juice_card_until(card, eval, true)
        end

        if context.reroll_shop and 
        (to_big(G.GAME.dollars + (G.GAME.dollar_buffer or 0))) >= to_big(3) 
        and card.ability.extra.times_available_counter_non < card.ability.extra.times_available_reset_num then
            card.ability.extra.times_available_counter_non = card.ability.extra.times_available_counter_non + 1
            ease_dollars(-card.ability.extra.fee_non)
            SMODS.add_booster_to_shop()

            local eval = function(card) 
                local _value = (card.ability.extra.times_available_counter_non < card.ability.extra.times_available_reset_num)
                local _location = true

                if G.GAME.blind.in_blind then
                    _location = false
                end

                local _return = true
                if _location == false or _value == false then
                    _return = false
                end
                return _return
            end
            juice_card_until(card, eval, true)
        end
    end
}