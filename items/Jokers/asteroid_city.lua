SMODS.Joker {
    key = "asteroid_city",
    order = 200,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 3},
    cost = 8,
    blueprint_compat = false,
    perishable_compat = false,
    kino_joker = {
        id = 747188,
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
    pools, k_genre = {"Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
            }
        }
    end,
    calculate = function(self, card, context)
        -- Upon entering a blind, abduct the joker to the right
        -- Return it Negative
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.setting_blind and card.ability.extra.num_cards_abducted_non == 0 and not card.getting_sliced then
            -- find position
            local _mypos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    _mypos = i
                end
            end
            
            if _mypos and G.jokers.cards[_mypos + 1] and not 
            G.jokers.cards[_mypos + 1].getting_sliced and not
            G.jokers.cards[_mypos + 1].abducted then  
                Kino.abduct_card(card, G.jokers.cards[_mypos + 1])
            end
        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            for _index, _card in ipairs(Kino.gather_abducted_cards_by_abductor(card)) do
                _card:set_edition("e_negative", true, nil, true)
            end
            -- for i, _object in ipairs(card.ability.extra.cards_abducted) do
                
            --     _object.card:set_edition("e_negative", true, nil, true)
            -- end
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