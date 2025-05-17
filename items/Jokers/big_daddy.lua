SMODS.Joker {
    key = "big_daddy",
    order = 272,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9032,
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
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand then
            local _hasKing = false
            for _, _pcard in ipairs(context.scoring_hand) do
                if _pcard:get_id() == 13 then
                    _hasKing = true
                    break
                end
            end

            if _hasKing then
                for _, _pcard in ipairs(context.scoring_hand) do
                    if _pcard:is_face() ~= true then
                        local _target = _pcard
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                            _target:juice_up(0.8, 0.5)
                            card:juice_up(0.8, 0.5)
                            card_eval_status_text(_target, 'extra', nil, nil, nil,
                            { message = localize('k_kino_big_daddy'), colour = G.C.MULT })
                            _target:flip()
                            delay(0.1)
                            SMODS.change_base(_target, nil, '2')
                            _target:flip()
                            delay(0.23)
                        return true end }))
                        
                    end
                end
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.Mult })
            end

            
        end
    end
}