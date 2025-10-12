SMODS.Joker {
    key = "blank_check",
    order = 143,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 1000
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 4, y = 5},
    cost = 0,
    blueprint_compat = false,
    perishable_compat = false,
    kino_joker = {
        id = 13962,
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
    k_genre = {"Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "bust_econ"}
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you buy this joker, get $1000. set money to 0 and self-destruct when you leave the shop
        if context.ending_shop then
            card.getting_sliced = true
            G.E_MANAGER:add_event(Event({func = function()
                (context.blueprint_card or card):juice_up(0.8, 0.8)
                card:start_dissolve({G.C.RED}, nil, 1.6)
            return true end }))
        end
    
    end,
    add_to_deck = function(self, card, from_debuff)
        local _money = card.ability.extra.money - G.GAME.dollars
        if card and card.juice_card then
            card:juice_card()
        end
        ease_dollars(_money)
	end,
    remove_from_deck = function(self, card, from_debuff)
        if card and card.juice_card then
            card:juice_card()
        end
        ease_dollars(-G.GAME.dollars)
	end,
}