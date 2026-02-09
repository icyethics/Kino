SMODS.Joker {
    key = "junior",
    order = 72,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_count = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 6280,
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
    k_genre = {"Romance", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_count
            }
        }
    end,
    calculate = function(self, card, context)
        -- Creates a holographic 2 in hand for every 10 kings and jacks scored
        if context.individual and context.cardarea == G.play then
            if (context.other_card.base.id == 11 or context.other_card.base.id == 13)
            and not context.other_card.debuff then
                card.ability.extra.stacked_count = card.ability.extra.stacked_count + 1
            end

            if card.ability.extra.stacked_count == 10 then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _pool = {G.P_CARDS.H_2, G.P_CARDS.C_2, G.P_CARDS.D_2, G.P_CARDS.S_2}
                        local _card = create_playing_card({
                            front = pseudorandom_element(_pool, pseudoseed('ghoulies')), 
                            center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        _card:set_edition({polychrome = true})
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        return true
                    end}))

                card.ability.extra.stacked_count = 0

                playing_card_joker_effects({true})
            end
        end
    end
}