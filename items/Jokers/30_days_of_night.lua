SMODS.Joker {
    key = "30_days_of_night",
    order = 125,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_active = true,
        extra = {
            is_active = true,
            stacked_x_mult = 1,
            a_xmult = 0.25,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    is_active = true,
    kino_joker = {
        id = 4513,
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
    k_genre = {"Horror"},
    -- set_ability = function(self, card, initial, delay_sprites)
    --     if card.ability.is_active then print("1") end
    --     if card.is_active then print("2") end
    --     card.is_active = true
    -- end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.is_active,
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult,
            }
        }
    end,
    calculate = function(self, card, context)
        -- While Active, does vampire effect but does not give score
        -- While inactive, gives score. If used in inactive mode, loses ability to gain active score

        if context.before and card.ability.extra.is_active == true and 
        G.jokers.cards[1] == card and not context.blueprint then
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
                    enhanced[#enhanced+1] = v
                    v.vampired = true
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            v.vampired = nil
                            return true
                        end
                    }))
                end
            end

            if #enhanced > 0 then
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult * #enhanced
                return {
                    extra = { focus = card,
                    message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.a_xmult * #enhanced}}),
                    colour = G.C.MULT,
                    card = card
                    }
                }
            end
        end

        if context.joker_main and 
        (G.jokers.cards[1] ~= card or card.ability.extra.is_active == false) then
            card.ability.extra.is_active = false
            card.ability.is_active = false

            return {
                card = card,
                x_mult = card.ability.extra.stacked_x_mult
            }
        end
    end
}