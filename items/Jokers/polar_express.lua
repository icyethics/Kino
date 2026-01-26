SMODS.Joker {
    key = "polar_express",
    order = 143,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 20,
            mult = 4,
            money = 4,
            xmult = 1.5,
            goodness_non = 1,
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
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.money,
                card.ability.extra.xmult,
                card.ability.extra.goodness_non,
                colours = {
                    card.ability.extra.goodness_non >= 8 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.goodness_non >= 6 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.goodness_non >= 4 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.goodness_non >= 2 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.goodness_non >= 0 and G.C.FILTER or G.C.INACTIVE,
                }
            },
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard then
            if card.ability.extra.goodness_non > 0 then
                card.ability.extra.goodness_non = math.max(card.ability.extra.goodness_non - 1, 0)
                card:juice_up()
                return {
                    message = localize("k_kino_goodness_lost")
                }
            end
        end

        if context.joker_main then
            local _ret = {}
            if card.ability.extra.goodness_non < 2 then
                _ret.message = localize("k_polar_express_bad")
            end
            if card.ability.extra.goodness_non >= 2 then
                _ret.chips = card.ability.extra.chips
                _ret.message = localize("k_polar_express_good")
            end
            if card.ability.extra.goodness_non >= 4 then
                _ret.mult = card.ability.extra.mult
            end
            if card.ability.extra.goodness_non >= 8 then
                _ret.x_mult = card.ability.extra.xmult
            end

            return _ret
        end

        if context.end_of_round and context.cardarea == G.jokers  and not context.repetition and not context.blueprint and G.GAME.current_round.discards_left > 0 then
            card.ability.extra.goodness_non = math.min(card.ability.extra.goodness_non + G.GAME.current_round.discards_left, 10)
            return {
                message = "+" .. tostring(G.GAME.current_round.discards_left),
                colour = G.C.MULT
            }
        end
        
    end,
    calc_dollar_bonus = function(self, card)
        local money = card.ability.extra.goodness_non >= 6 and card.ability.extra.money or 0

        return money
    end,
}