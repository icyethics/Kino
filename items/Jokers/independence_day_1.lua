SMODS.Joker {
    key = "independence_day_1",
    order = 207,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            lower_by = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 2, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 602,
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
    k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "keyword_abduct"}
        info_queue[#info_queue+1] = Kino.abduction_info_queue(card)
        return {
            vars = {
                card.ability.extra.lower_by
            }
        }
    end,
    calculate = function(self, card, context)
        -- Lower the boss blind by 5% for each card that is currently abducted
        if context.first_hand_drawn then
            if G.GAME.blind.boss then
                card:juice_up(0.8, 0.8)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_independence_day'), colour = G.C.BLACK })
                
                G.GAME.blind.chips = G.GAME.blind.chips * ((100 - (card.ability.extra.lower_by * #Kino.abduction.cards)) / 100)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end
    end
}