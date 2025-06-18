SMODS.Joker {
    key = "predator",
    order = 40,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            predator_card = nil,
            x_mult = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 0},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 106,
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
    pools, k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.predator_card,
                card.ability.extra.x_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        -- Turn one of the cards in your opening hand into a hidden predator card.
        -- Gives x3 when triggered.
        if context.first_hand_drawn and card.ability.extra.predator_card == nil and not context.blueprint then
            -- card.ability.extra.predator_card = pseudorandom_element(context.hand_drawn, pseudoseed("kino_predator"))
            local _pcard = pseudorandom_element(context.hand_drawn, pseudoseed("kino_predator"))
            _pcard.marked_by_predator = true

            local eval = function(card)
                local result = false
                for _, _card in ipairs(G.hand.cards) do
                    if _card.marked_by_predator then
                        result = true
                    end
                end
            return result end
            juice_card_until(card, eval, true)
        end

        if context.individual and context.other_card.marked_by_predator and
        context.cardarea == G.play then
            context.other_card.marked_by_predator = false
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.end_of_round and not context.blueprint then
            for _, _pcard in ipairs(G.playing_cards) do
                if _pcard.marked_by_predator == true then
                    _pcard.marked_by_predator = nil
                end
            end
        end
    end
}