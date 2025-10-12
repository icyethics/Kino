SMODS.Joker {
    key = "chef",
    order = 16,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 212778,
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
    k_genre = {"Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- when you select a blind, create a random confection
        if context.setting_blind then
            if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("confection", G.pack_cards, nil, nil, true, true, nil, "kino_chef")
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                    card_eval_status_text(context.blueprint_card or card, 
                    'extra', nil, nil, nil, {message = localize('k_chef'), colour = G.C.CHIPS})                
            end
        end
    end
}