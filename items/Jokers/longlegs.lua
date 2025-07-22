SMODS.Joker {
    key = "longlegs",
    order = 118,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 3,
            hidden_card = nil
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1226578,
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
    pools, k_genre = {"Horror", "Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.hidden_card
            }
        }
    end,
    calculate = function(self, card, context)
        -- 3x. When you destroy or play the hidden card, debuff and set score to 0.
        if not card.ability.extra.hidden_card and not context.blueprint then
            -- card.ability.extra.hidden_card = pseudorandom_element(G.deck.cards)
            local _pcard = pseudorandom_element(G.playing_cards)
            card.ability.extra.hidden_card = true
            _pcard.marked_by_longlegs = true
        end
        

        if context.hand_drawn then
            local eval = function(card)
                local result = false
                for _, _card in ipairs(G.hand.cards) do
                    if _card.marked_by_longlegs then
                        result = true
                    end
                end
                return result end
            juice_card_until(card, eval, true)
        end

        if context.joker_main then
            -- Check if the card is the hidden card.
            local _turned_on = true
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].marked_by_longlegs then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_longlegs_ex'), colour = G.C.RED })
                    card_eval_status_text(context.scoring_hand[i], 'extra', nil, nil, nil,
                    { message = localize('k_longlegs_ex'), colour = G.C.RED })
                    G.GAME.chips = 0
                    G.E_MANAGER:add_event(Event({
                        trigger = 'ease',
                        blocking = false,
                        ref_table = G.GAME,
                        ref_value = 'chips',
                        ease_to = G.GAME.chips,
                        delay =  0.5,
                        func = (function(t) return math.floor(t) end)
                      }))
                      _turned_on = false
                      SMODS.debuff_card(card, true, "longlegs")
                    break
                end
            end

            if _turned_on then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end

        if context.remove_playing_cards then
            for _, _pcard in ipairs(context.removed) do
                if _pcard.marked_by_longlegs then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_longlegs_ex'), colour = G.C.RED })
                    SMODS.debuff_card(card, true, "longlegs")
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, _pcard in ipairs(G.playing_cards) do
            if _pcard.marked_by_longlegs then
                _pcard.marked_by_longlegs = nil
            end
        end
    end
}