SMODS.Joker {
    key = "close_encounters",
    order = 91,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
            a_chips = 20,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 840,
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
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
                card.ability.extra.a_chips,
                (Kino.abduction and Kino.abduction.cards) and (#Kino.abduction.cards * card.ability.extra.a_chips) or 0
            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play a High Card, abduct it
        -- Gives 20 chips for each card currently abducted
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.joker_main then
            return {
                chips = #Kino.abduction.cards * card.ability.extra.a_chips
            }
        end

        if context.after and context.cardarea == G.jokers and context.scoring_hand and #context.scoring_hand == 1 then
            Kino.abduct_card(card, context.scoring_hand[1])
        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            card.ability.extra.cards_abducted = Kino.unabduct_cards(card)
        end
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