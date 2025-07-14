SMODS.Joker {
    key = "get_out",
    order = 44,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            selected_cards = 3,
            temp_card = nil
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    kino_joker = {
        id = 419430,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.selected_cards
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a high card,
        -- Change 3 random cards in your hand into copies of it
        -- then destroy this joker
        -- if context.before and #context.full_hand == 1 and not context.blueprint and not context.repetition then
        --     card.ability.extra.temp_card = context.full_hand[1]
        -- end

        if context.after and context.full_hand and #context.full_hand == 1 and not context.blueprint and not context.repetition then
            local _cards = {}

            for i = 1, card.ability.extra.selected_cards do
                _cards[i] = pseudorandom_element(G.hand.cards, pseudoseed("get_out"))
            end

            for i = 1, #_cards do
                local _other = context.full_hand[1]
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    local new_card = copy_card(_other, _cards[i])
                    new_card:juice_up()
                    return true end }))
            end

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