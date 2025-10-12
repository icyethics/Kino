SMODS.Joker {
    key = "iron_giant",
    order = 83,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 0.1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 4, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10386,
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
    k_genre = {"Sci-fi", "Animation", "Family"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- sci_fi cards give x1.00 + x0.1 for each time they've upgraded, when held in hand.
        if context.individual and context.cardarea == G.hand and 
        context.other_card.config.center == G.P_CENTERS.m_kino_sci_fi
        and not context.end_of_round then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED,
                    card = card,
                }
            end

            local level = context.other_card.ability.times_upgraded
            if level > 0 then
                local _x_mult = 1 + (card.ability.extra.a_xmult * level)
                return {
                    x_mult = _x_mult,
                    message = localize{type='variable', key = 'a_xmult', vars = {_x_mult}}
                }
            end
        end
    end
}