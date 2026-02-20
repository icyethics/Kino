SMODS.Joker {
    key = "oceans_11",
    order = 132,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 3},
    cost = 15,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 161,
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
    k_genre = {"Crime", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Booster packs are free
        
    end,
    add_to_deck = function(self, card, from_debuff)
        if not card.from_quantum then
            G.GAME.kino_oceans_11 = true
            if G.shop_booster and G.shop_booster.cards then
                for i = 1, #G.shop_booster.cards do
                    G.shop_booster.cards[i]:set_cost()
                end
            end
        end
	end,
    remove_from_deck = function(self, card, from_debuff)
        if not card.from_quantum then
            G.GAME.kino_oceans_11 = false
            if G.shop_booster and G.shop_booster.cards then
                for i = 1, #G.shop_booster.cards do
                    G.shop_booster.cards[i]:set_cost()
                end
            end
        end
	end,
}