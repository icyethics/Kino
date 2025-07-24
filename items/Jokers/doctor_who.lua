SMODS.Joker {
    key = "doctor_who",
    order = 203,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 15691,
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
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
            }
        }
    end,
    calculate = function(self, card, context)
        -- If in your active joker slot, abduct a random card from your hand. When returned, it will have a random edition and Enhancement
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.after and context.cardarea == G.jokers and G.jokers.cards[1] == card then
            local _target = pseudorandom_element(G.hand.cards, pseudoseed("drwho"))
            Kino.abduct_card(card, _target)
        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            for _index, _card in ipairs(Kino.gather_abducted_cards_by_abductor(card)) do
                local edition = poll_edition('drwho', nil, true, true)
                _card:set_edition(edition, true)

                local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'drwho'})
                _card:set_ability(G.P_CENTERS[new_enhancement])
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
        if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
            if not card.children.activedisplay then
                card.children.activedisplay = Kino.create_active_ui(card)
            end
        else
            card.children.activedisplay = nil
        end
        
    end,
}