SMODS.Joker {
    key = "when_harry_met_sally",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.25
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 639,
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
    pools, k_genre = {"Romance", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Scored Cards give X1.25 mult if there's a card with the same rank in your hand
        if context.individual and context.cardarea == G.play then
            local _rank = context.other_card:get_id()

            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:get_id() == _rank then
                    return {
                        x_mult = card.ability.extra.x_mult
                    }
                end
            end
        end
    end
}