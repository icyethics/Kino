SMODS.Joker {
    key = "fright_night",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 0.5,
            stacked_xmult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 2, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11797,
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
    is_vampire = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1]  = {set = 'Other', key = "keyword_drain"}
        return {
            vars = {
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before and not context.blueprint then
                -- Add mult and drain
                local enhanced = {}
                for k, v in ipairs(context.scoring_hand) do
                    if Kino.drain_property(v, card, {Seal = {true}}) then
                        enhanced[#enhanced+1] = v
                    end
                end

                if #enhanced > 0 then
                    card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + (card.ability.extra.a_xmult * #enhanced)
                    return {
                        extra = { focus = card,
                        message = localize({type='variable', key='a_mult', vars = {card.ability.extra.stacked_xmult}}),
                        colour = G.C.MULT,
                        card = card
                        }
                    }
                end
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end
    end
}