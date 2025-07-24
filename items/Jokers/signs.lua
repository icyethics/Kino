SMODS.Joker {
    key = "signs",
    order = 201,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
            a_mult = 2,
            valid_targets = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 2, y = 3},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2675,
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
    pools, k_genre = {"Sci-fi", "Horror"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
                card.ability.extra.a_mult,
                Kino.abduction and (#Kino.abduction.cards * card.ability.extra.a_mult) or 0
            }
        }
    end,
    calculate = function(self, card, context)
        -- Abduct a random unscored card. Gives +2 Mult for each card abducted
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.before then
            card.ability.extra.valid_targets = {}
        end

        if context.individual and context.cardarea == "unscored" then
            
            card.ability.extra.valid_targets[#card.ability.extra.valid_targets + 1] = context.other_card
        end

        if context.joker_main then
            return {
                mult = #Kino.abduction.cards * card.ability.extra.a_mult
            }
        end

        if context.after and context.cardarea == G.jokers and #card.ability.extra.valid_targets > 0 then
            local _target = pseudorandom_element(card.ability.extra.valid_targets, pseudoseed("signs"))
            Kino.abduct_card(card, _target)
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