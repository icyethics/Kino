SMODS.Joker {
    key = "snowpiercer",
    order = 226,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 4
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 110415,
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
    pools, k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind, destroy all consumables you have, and gain +4 mult per consumable
        if context.setting_blind and not context.retrigger and not context.blueprint then
            for _, _con in ipairs(G.consumeables.cards) do
                card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
                _con.getting_sliced = true
                G.E_MANAGER:add_event(Event({func = function()
                    (context.blueprint_card or card):juice_up(0.8, 0.8)
                    _con:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}