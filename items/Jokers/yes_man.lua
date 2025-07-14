SMODS.Joker {
    key = "yes_man",
    order = 122,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    kino_joker = {
        id = 10201,
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
    pools, k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)

        if context.before and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.discard and not context.repetition and not context.blueprint then
            if not context.blueprint and not context.retrigger then
                card.getting_sliced = true
                G.E_MANAGER:add_event(Event({func = function()
                    card:juice_up(0.8, 0.8)
                    card:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
        end
    end
}