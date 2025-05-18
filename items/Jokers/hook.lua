SMODS.Joker {
    key = "hook",
    order = 94,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 3},
    cost = 2,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 879,
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
    pools, k_genre = {"Fantasy", "Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- Turn scored face cards into random non-face card
        if context.after and context.scoring_hand then 
            for i = 1, #context.scoring_hand do
                local i_card = context.scoring_hand[i]
                if i_card:is_face() then
                    local _ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10"}
                    local _rank = pseudorandom_element(_ranks, pseudoseed("hook"))                    
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                        i_card:juice_up(0.8, 0.5)
                        card:juice_up(0.8, 0.5)
                        card_eval_status_text(i_card, 'extra', nil, nil, nil,
                        { message = localize('k_hook'), colour = G.C.MULT })
                        SMODS.change_base(i_card, nil, _rank)
                        delay(0.23)
                    return true end }))
                end
            end 
        end
    end
}