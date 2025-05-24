SMODS.Joker {
    key = "fargo",
    order = 219,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 2, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 275,
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
    pools, k_genre = {"Crime"},
    enhancement_gate = "m_kino_crime",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_steal", vars = {Kino.crime_chips, tostring(G.GAME.money_stolen)}}
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- Destroy the first discarded card and add $5 to the stolen value
        
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.discard and not context.blueprint and 
        G.GAME.current_round.discards_used <= 0 and context.full_hand and #context.full_hand == 1 then
            Kino.increase_money_stolen(card.ability.extra.money)
            return {
                remove = true
            }
        end
    end
}