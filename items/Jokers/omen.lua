SMODS.Joker {
    key = "omen",
    order = 115,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 300,
            goal = 13
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 794,
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
    k_genre = {"Horror"},
    enhancement_gate = "m_kino_demonic",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.goal,
                G.GAME.current_round.sacrifices_made
            }
        }
    end,
    calculate = function(self, card, context)
        -- +300 chips if you've made more than 13 sacrifices this game. 

        if context.joker_main and G.GAME.current_round.sacrifices_made >= card.ability.extra.goal then
            return {
                chips = card.ability.extra.chips
            }
        end
        
    end
}