SMODS.Joker {
    key = "dark_knight",
    order = 104,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 155,
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
    pools = {["kino_batman"] = true}, 
    k_genre = {"Superhero", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind, destroy all JOKERS
        -- Gain x0.5 per joker destroyed.
        -- Can't destroy batman jokers.

        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local _jokers_destroyed = 0
            for i = 1, #G.jokers.cards do
                if not kino_quality_check(G.jokers.cards[i], "is_batman") and 
                not SMODS.is_eternal(G.jokers.cards[i], {kino_dark_knight = true, joker = true}) and
                G.jokers.cards[i]:can_calculate() then
                    _jokers_destroyed = _jokers_destroyed + 1
                    G.jokers.cards[i].getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        if G.jokers and G.jokers.cards and G.jokers.cards[i] then
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            G.jokers.cards[i]:start_dissolve({G.C.RED}, nil, 1.6)
                        end
                    return true end }))
                end
            end

            if _jokers_destroyed > 0 then
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + (_jokers_destroyed * card.ability.extra.a_xmult)
                return {
                    extra = { focus = card,
                    message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.stacked_x_mult}}),
                    colour = G.C.MULT,
                    card = card
                    }
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
            }
        end

    end
}