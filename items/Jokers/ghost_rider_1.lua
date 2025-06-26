SMODS.Joker {
    key = "ghost_rider_1",
    order = 120,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1250,
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
    pools, k_genre = {"Superhero", "Action", "Fantasy"},
    enhancement_gate = 'm_kino_demonic',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Destroy a random Demonic card in hand to gain x.25
        if context.joker_main and not context.blueprint then
            local _demons = {}
            for i = 1, #G.hand.cards do
                if SMODS.has_enhancement(G.hand.cards[i], 'm_kino_demonic') then
                    _demons[#_demons + 1] = G.hand.cards[i]
                end
            end

            if #_demons > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_ghost_rider_1'), colour = G.C.BLACK })
                local _destroyed_card = pseudorandom_element(_demons)
                _destroyed_card.destroyed = true
                _destroyed_card.marked_to_destroy_by_ghost_rider = true

                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
            end

            if card.ability.extra.stacked_x_mult > 0 then
                return {
                    x_mult = card.ability.extra.stacked_x_mult
                }
            end
        end

        if context.destroy_card and context.cardarea == G.hand then

            if context.destroy_card.marked_to_destroy_by_ghost_rider then
                return { remove = true }
            end
            
        end
    end
}