SMODS.Joker {
    key = "thing",
    order = 35,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 0},
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 1091,
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
    k_genre = {"Sci-fi", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(G.GAME.current_round.kino_thing_card and G.GAME.current_round.kino_thing_card.suit or "Spades", "suits_singular"),
                colours = {
                    G.C.SUITS[G.GAME.current_round.kino_thing_card and G.GAME.current_round.kino_thing_card.suit or "Spades"]
                }
            }
        }
    end
}