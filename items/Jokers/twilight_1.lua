SMODS.Joker {
    key = "twilight_1",
    order = 148,
    config = {
        extra = {
            x_mult = 0,
            a_xmult = 0.1,
            romance_bonus = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    pools, k_genre = {"Romance", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult,
                card.ability.extra.romance_bonus
            }
        }
    end,
    calculate = function(self, card, context)
        -- vampire, doesn't drain romance cards.
        -- when romance cards trigger, gain that much bonus
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base and v.config.center ~= G.P_CENTERS.m_kino_romance
                and not v.debuff and not v.vampired then
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
                card.ability.extra.x_mult = card.ability.extra.x_mult + (card.ability.extra.a_xmult * #enhanced)
                card.ability.extra.romance_bonus = card.ability.extra.x_mult
            end

            SMODS.calculate_context({twilight_rom = true, x_mult = card.ability.extra.x_mult})

            if #enhanced > 0 then
                return {
                    extra = { focus = card,
                    message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.x_mult}}),
                    colour = G.C.MULT,
                    card = card
                    }
                }
            end
        end
    end
}