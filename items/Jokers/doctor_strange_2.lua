SMODS.Joker {
    key = "doctor_strange_2",
    order = 206,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 5},
    cost = 11,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 453395,
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
    k_genre = {"Superhero", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- After you play a hand, return your hand to deck and draw that many new card

        if context.after and G.jokers.cards[1] == card then
            local hand_count = #G.hand.cards
            for i=1, hand_count do
                draw_card(G.hand,G.deck, i*100/hand_count,'down', nil, nil, 0.07)
            end
            G.deck:shuffle()
            for i=1, hand_count do
                draw_card(G.deck,G.hand, i*100/hand_count,'down', nil, nil, 0.07)
            end
        end
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
            if not card.children.activedisplay then
                card.children.activedisplay = Kino.create_active_ui(card)
            end
        else
            card.children.activedisplay = nil
        end
    end,
}