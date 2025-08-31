SMODS.Joker {
    key = "exorcist_1",
    order = 197,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    enhancement_gate = "m_kino_demonic",
    kino_joker = {
        id = 9552,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_demonic
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cleanse demon cards after scoring
        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
            }
        end

        if context.after and not context.blueprint then
            local _demonic = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_kino_demonic and not v.debuff and not v.vampired and not v.cleansed then
                    v.cleansed = true
                    _demonic[#_demonic + 1] = v
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end

            if #_demonic > 0 then
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + (card.ability.extra.a_xmult * #_demonic)
                return {
                    extra = { focus = card,
                    message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.mult}}),
                    colour = G.C.MULT,
                    card = card
                    }
                }
            end
        end
    end
}