SMODS.Joker {
    key = "stargate",
    order = 205,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
            stacked_chips = 0,
            a_chips = 25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2164,
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
    pools, k_genre = {"Sci-fi", "Adventure"},
    enhancement_gate = "m_stone",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- abduct stone cards. return them unstoned and get +25 chips for each one
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end

        if context.individual and SMODS.has_enhancement(context.other_card, "m_stone") 
        and not context.blueprint and not context.retrigger then
            Kino.abduct_card(card, context.scoring_hand[1])
        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            for _index, _card in ipairs(Kino.gather_abducted_cards_by_abductor(card)) do
                _card:set_ability(G.P_CENTERS.c_base)
                card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
            end
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