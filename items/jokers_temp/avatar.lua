SMODS.Joker {
    key = "avatar",
    order = 63,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 19995,
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
    k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you use a planet, this gains +chips equal to the level of your most played hand.
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == "Planet" then
                local _hand, _tally = nil, -1
                for k, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _tally = G.GAME.hands[v].played
                    end
                end

                card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + (_tally * card.ability.extra.a_chips)
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips,
                card = card
            }
        end
    end
}