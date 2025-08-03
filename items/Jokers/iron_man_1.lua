SMODS.Joker {
    key = "iron_man_1",
    order = 81,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 1},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1726,
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
    k_genre = {"Sci-fi", "Superhero", "Action"},
    enhancement_gate = "m_kino_sci_fi",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If all cards in your first hand played are the same suit, upgrade every sc-fi card in your hand.
        if context.before and G.GAME.current_round.hands_played == 0 then
            -- and G.GAME.current_round.hands_played == 0
            local is_same = false
            local suits = {
                "Spades",
                "Hearts",
                "Clubs",
                "Diamonds"
            }
            for i = 1, #suits do
                local suit_count = 0
                local suit = suits[i]
                for j=1, #context.full_hand do
                    if context.full_hand[j]:is_suit(suit, nil, true) then
                        suit_count = suit_count + 1
                    end
                end
                if suit_count == #context.full_hand then
                    is_same = true
                    break
                end
            end

            if is_same then
                SMODS.calculate_context({sci_fi_upgrade = true})
            end
        end
    end
}