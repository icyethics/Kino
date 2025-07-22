SMODS.Joker {
    key = "moonfall",
    order = 206,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            num_cards_abducted_non = 0,
            chips = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 4},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 406759,
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
        local _count = 0
        if G.playing_cards then
            for i, _pc in ipairs(G.playing_cards) do
                if _pc:is_suit("Clubs") then
                    _count = _count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.num_cards_abducted_non,
                card.ability.extra.chips,
                _count * card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- On your first hand played, abduct all scoring non-club cards
        -- Release: Release them as club cards
        -- Gives +5 chips for each clubs in your starting deck
        card.ability.extra.num_cards_abducted_non = card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0

        if context.after and context.scoring_hand and context.cardarea == G.jokers
        and G.GAME.current_round.hands_played == 0 then
            for _, _card in ipairs(context.scoring_hand) do
                if SMODS.has_no_suit(_card) or not _card:is_suit("Clubs") then
                    Kino.abduct_card(card, _card)
                end
            end
        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            for _index, _card in ipairs(Kino.gather_abducted_cards_by_abductor(card)) do
                _card:change_suit("Clubs")
            end
            -- for i, _object in ipairs(card.ability.extra.cards_abducted) do
            --     local _card = _object.card
            --     _card:change_suit("Clubs")
            -- end
            card.ability.extra.cards_abducted = Kino.unabduct_cards(card)
        end

        if context.joker_main then
            local _count = 0
            for i, _pc in ipairs(G.playing_cards) do
                if _pc:is_suit("Clubs") then
                    _count = _count + 1
                end
            end

            return {
                chips = _count * card.ability.extra.chips
            }
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