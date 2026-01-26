SMODS.Joker {
    key = "blank_check",
    order = 143,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            counters_applied = 3,
            threshold = 2,
            active = true
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
                card.ability.extra.counters_applied,
                card.ability.extra.threshold,
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you buy this joker, get $1000. set money to 0 and self-destruct when you leave the shop
        -- if context.ending_shop then
        --     card.getting_sliced = true
        --     G.E_MANAGER:add_event(Event({func = function()
        --         (context.blueprint_card or card):juice_up(0.8, 0.8)
        --         card:start_dissolve({G.C.RED}, nil, 1.6)
        --     return true end }))
        -- end
        if context.kino_enter_shop then
            card.ability.extra.active = true
            local eval = function(card) 
                local _value = card.ability.extra.active
                local _location = true

                if G.GAME.blind.in_blind then
                    _location = false
                end

                local _return = true
                if _location == false or _value == false then
                    _return = false
                end
                return _return
            end
            juice_card_until(card, eval, true)
        end
        
        if context.buying_card and not context.buying_self and card.ability.extra.active == true then
            if to_big(context.card.cost) > to_big(0) then
                ease_dollars(context.card.cost)

                local _counters_applied = math.floor(card.ability.extra.counters_applied * (context.card.cost / card.ability.extra.threshold))
                local _targets = Blockbuster.Counters.get_counter_targets(G.playing_cards, {"none", "match"}, "counter_debt")
                
                for i = 1, _counters_applied do
                    local _target = pseudorandom_element(_targets, pseudoseed("kino_blank_check"))
                    _target:bb_counter_apply("counter_debt", 1)
                end

                card.ability.extra.active = false
            end
        end
    end,
}