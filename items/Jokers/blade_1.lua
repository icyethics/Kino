SMODS.Joker {
    key = "blade_1",
    order = 136,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1,
            x_chips = 1,
            chips = 0,
            mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 36647,
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
    pools, k_genre = {"Superhero", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.x_chips,
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- when selecting a blind, destroy the vampire joker on the left. 
        -- gain all it's levelling.
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local _my_pos = nil
            for i = 1, #G.jokers.cards do 
                if G.jokers.cards[i] == card then 
                    _my_pos = i
                    break
                end
            end

            if _my_pos and G.jokers.cards[_my_pos + 1] and not 
            G.jokers.cards[_my_pos + 1].getting_sliced and not
            -- G.jokers.cards[_my_pos + 1].ability.eternal then
            SMODS.is_eternal(G.jokers.cards[_my_pos + 1], {kino_blade = true, joker = true}) then
                if G.jokers.cards[_my_pos + 1].config.center.is_vampire or G.jokers.cards[_my_pos + 1].config.center.key == "j_vampire" then
                    if G.jokers.cards[_my_pos + 1].config.center.is_vampire or G.jokers.cards[_my_pos + 1].config.center.key == "j_vampire" then

                        
                        -- steals x_mult
                        if G.jokers.cards[_my_pos + 1].ability.extra.x_mult then
                            card.ability.extra.x_mult = card.ability.extra.x_mult + G.jokers.cards[_my_pos + 1].ability.extra.x_mult
                        end

                        --
                        if G.jokers.cards[_my_pos + 1].ability.extra.x_chips then
                            card.ability.extra.x_chips = card.ability.extra.x_chips + G.jokers.cards[_my_pos + 1].ability.extra.x_chips
                        end

                        if G.jokers.cards[_my_pos + 1].ability.extra.mult then
                            card.ability.extra.mult = card.ability.extra.mult + G.jokers.cards[_my_pos + 1].ability.extra.mult
                        end

                        if G.jokers.cards[_my_pos + 1].ability.extra.chips then
                            card.ability.extra.chips = card.ability.extra.chips + G.jokers.cards[_my_pos + 1].ability.extra.chips
                        end

                        if G.jokers.cards[_my_pos + 1].ability.extra.romance_bonus then
                            card.ability.extra.x_chips = card.ability.extra.x_chips + G.jokers.cards[_my_pos + 1].ability.extra.romance_bonus
                        end

                        G.jokers.cards[_my_pos + 1].getting_sliced = true
                        G.E_MANAGER:add_event(Event({func = function()
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            G.jokers.cards[_my_pos + 1]:start_dissolve({G.C.RED}, nil, 1.6)
                            return true end }))

                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_blade_ex'), colour = G.C.BLACK })
                    end
                end
            end
            
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips,
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}