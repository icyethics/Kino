SMODS.Joker {
    key = "they_live",
    order = 202,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
            a_dollar = 1,
            payout_non = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 3, y = 3},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8337,
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
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
                card.ability.extra.a_dollar,
                card.ability.extra.num_cards_abducted_non * card.ability.extra.a_dollar,
                card.ability.extra.payout_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- Abduct every card on your first discard. Give $1 per abducted card at the end of the round
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.discard and context.cardarea == G.jokers and G.GAME.current_round.discards_used <= 0 then
            card.ability.extra.payout_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0
            Kino.abduct_card(card, context.other_card)
            card.ability.extra.payout_non = card.ability.extra.payout_non + 1
        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            card.ability.extra.cards_abducted = Kino.unabduct_cards(card)
        end
        
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.payout_non * card.ability.extra.a_dollar
    end,
    add_to_deck = function(self, card, from_debuff)
        card.children.abduction_display = Kino.create_abduction_ui(card)
        card.children.abduction_display_2 = Kino.create_abduction_ui_2(card)
        Kino.register_abducter_entity(card)
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers then
            if not card.children.abduction_display and card.ability.extra.cards_abducted  then
                card.children.abduction_display = Kino.create_abduction_ui(card)
                card.children.abduction_display_2 = Kino.create_abduction_ui_2(card)
            end
        end
    end,
}