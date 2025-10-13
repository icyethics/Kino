SMODS.Joker {
    key = "guardians_of_the_galaxy_1",
    order = 169,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 1,
            a_mult_better = 1,
            -- a_mult = 5,
            -- special_a_mult = 8
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 118340,
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
    k_genre = {"Sci-fi", "Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.stacked_mult
                
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind, gain Mult per planet, for each planet you have

        if context.setting_blind then
            local _total_planets = 0
            local _total_egos = 0
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == "Planet" then
                    _total_planets = _total_planets + 1
                    if G.consumeables.cards[i].config.center.key == "c_kino_ego" then
                        _total_egos = _total_egos + 1
                    end

                    card:juice_up()
                    card_eval_status_text(G.consumeables.cards[i], 'extra', nil, nil, nil,
                    { message = localize('k_kino_guardians_1'), colour = G.C.LEGENDARY})
                end
            end

            -- Normal planets
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + ((card.ability.extra.a_mult * _total_planets) * _total_planets)
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + ((card.ability.extra.a_mult_better * _total_egos) * _total_planets)
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end

        -- OLD EFFECT
        -- if context.joker_main then
        --     local _mult = 0
        --     for i = 1, #G.consumeables.cards do
        --         if G.consumeables.cards[i].ability.set == "Planet" then
        --             if G.consumeables.cards[i].key == "c_kino_ego" then
        --                 _mult = _mult + card.ability.extra.special_a_mult
        --             else 
        --                 _mult = _mult + card.ability.extra.a_mult
        --             end
        --         end
        --     end

        --     return {
        --         mult = _mult
        --     }
        -- end
    end
}