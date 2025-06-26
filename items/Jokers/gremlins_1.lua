SMODS.Joker {
    key = "gremlins_1",
    order = 189,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 2, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 927,
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
    pools, k_genre = {"Family", "Horror"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_horror") or
                SMODS.has_enhancement(v, "m_kino_monster") then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Unscored cards give +10 chips for each monster card in your hand
        if context.individual and context.cardarea == "unscored" then
            local _count = 0
            for i, _card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(_card, "m_kino_monster") then
                    _count = _count + 1
                end
            end

            return {
                chips = _count * card.ability.extra.chips
            }
        end

        if context.joker_main then
            for i, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center == G.P_CENTERS.j_splash or 
                _joker.config.center.is_water or 
                _joker.config.center == G.P_CENTERS.j_seltzer or
                _joker.config.center == G.P_CENTERS.j_diet_cola 
                then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _joker:flip()
                            _joker:juice_up()
                            _joker:set_ability('j_kino_gremlins_1')
                            _joker:flip()
                            card_eval_status_text(_joker, 'extra', nil, nil, nil,
                            { message = localize('k_gremlins'), colour = G.C.BLACK })
                            return true
                        end
                    }))
                end
            end
        end
    end
}