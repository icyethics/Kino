SMODS.Joker {
    key = "stand_by_me",
    order = 65,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 4},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 235,
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
    k_genre = {"Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a straight, get a negative hangman
        if context.joker_main and (context.scoring_name == "Straight" or context.scoring_name == "Straight Flush") then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = create_card("Tarot",G.consumeables, nil, nil, nil, nil, "c_hanged_man", "stand_by_me")
                    card:set_edition({negative = true}, true)
                    card:add_to_deck()
                    G.consumeables:emplace(card) 
                    return true
                end}))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
        end

    end
}