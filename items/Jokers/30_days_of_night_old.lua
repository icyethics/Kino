SMODS.Joker {
    key = "30_days_of_night",
    order = 125,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            is_active = true,
            stacked_x_mult = 1,
            a_xmult = 0.2,
            string = "Feeding"
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.is_active,
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult,
                card.ability.extra.string
            }
        }
    end,
    calculate = function(self, card, context)
        -- For the rest of the ante, drain enhancements from cards. After that, gives x0.1 per card drained.
        if card.ability.extra.is_active and context.cardarea == G.jokers and
        context.before and not context.blueprint then
            -- Add mult and drain
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
                    message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.mult}}),
                    colour = G.C.MULT,
                    card = card
                    }
                }
            end

        end

        -- Swap once relevant
        if context.end_of_round and G.GAME.blind.boss then
            card.ability.extra.is_active = false
            card.ability.extra.string = "Fed"
        end

        -- once the ante is over, do this.
        if context.joker_main and not card.ability.extra.is_active then
            return {
                card = card,
                x_mult = card.ability.extra.stacked_x_mult
            }
        end
    end
}