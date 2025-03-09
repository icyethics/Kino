SMODS.Joker {
    key = "nope",
    order = 45,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_abducted = {},
            stacked_mult = 0,
            a_mult = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 601,
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
    pools, k_genre = {"Family", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_abducted and #card.ability.extra.cards_abducted or 0,
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When your hand contains 5 cards, abduct a random card
        -- When the abduction ends, return it to the hand debuffed
        -- and increase mult by 3

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end

        if context.after and context.cardarea == G.jokers and #context.full_hand >= 5 then
            local _abductee = pseudorandom_element(context.full_hand, pseudoseed("nope"))
            Kino.abduct_card(card, _abductee)

        end

        if context.abduction_ending and not context.blueprint and not context.retrigger then
            Kino.debug_string = "Changed"
            for _, _cardinfo in ipairs(card.ability.extra.cards_abducted) do
                
                card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
                
                SMODS.debuff_card(_cardinfo.card, true, "nope")
            end

            card.ability.extra.cards_abducted = Kino.unabduct_cards(card)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.children.abduction_display = Kino.create_abduction_ui(card)
        card.children.abduction_display_2 = Kino.create_abduction_ui_2(card)
    end,
}