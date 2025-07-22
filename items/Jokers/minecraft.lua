SMODS.Joker {
    key = "minecraft",
    order = 278,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 950387,
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
    k_genre = {"Fantasy", "Comedy", "Adventure"},
    enhancement_gate = 'm_stone',
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand and context.cardarea == G.jokers then
            for _, _scoring_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(_scoring_card, 'm_stone') then
                    local _target_card = _scoring_card
                    if pseudorandom("minecraft") < 1 / 2 then
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.4,
                            func = function()
                                card:juice_up(0.3, 0.4)
                                _target_card:juice_up(0.3, 0.4)
                                _target_card:set_ability("m_steel")
                                return true
                            end,
                        }))
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize("k_minecraft_1"), colour = G.C.MULT})
                    else
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.4,
                            func = function()
                                card:juice_up(0.3, 0.4)
                                _target_card:juice_up(0.3, 0.4)
                                _target_card:set_ability("m_gold")
                                return true
                            end,
                        }))
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize("k_minecraft_2"), colour = G.C.MULT})
                    end
                end
            end
        end
    end
}