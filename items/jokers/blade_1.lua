SMODS.Joker {
    key = "blade_1",
    order = 136,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 36647,
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
    k_genre = {"Superhero", "Horror"},

    loc_vars = function(self, info_queue, card)
        local _count = 0
        if G.playing_cards and #G.playing_cards > 0 then
         _count = Blockbuster.Counters.get_total_counters("counter_kino_blood", "Full Deck").counter_values
        end
         return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult * _count
            }
        }
    end,
    calculate = function(self, card, context)
        -- when selecting a blind, destroy the vampire joker on the left. 
        -- gain all it's levelling.
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local _my_pos = nil
            for i = 1, #G.jokers.cards do 
                if G.jokers.cards[i] == card then 
                    _my_pos = i
                    break
                end
            end

            print(_my_pos)
            if _my_pos and G.jokers.cards[_my_pos + 1] and not 
            G.jokers.cards[_my_pos + 1].getting_sliced and not
            SMODS.is_eternal(G.jokers.cards[_my_pos + 1], {kino_blade = true, joker = true}) then
                local _val = G.jokers.cards[_my_pos + 1].sell_cost
                    local _isvamp = false
                    if G.jokers.cards[_my_pos + 1].config.center.is_vampire or G.jokers.cards[_my_pos + 1].config.center.key == "j_vampire" then
                        _val = _val * 2
                    end
                    G.jokers.cards[_my_pos + 1].getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        G.jokers.cards[_my_pos + 1]:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))

                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize(_isvamp and '_isvamp' or 'k_blade_reg'), colour = G.C.BLACK })
                    
                    for i = 1, _val do
                        local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_blade"))
                        _target:bb_counter_apply("counter_kino_blood", 1)
                end
            end
            
        end

        if context.joker_main then
            local _count = Blockbuster.Counters.get_total_counters("counter_kino_blood", "Full Deck").counter_values
            return {
                mult = _count * card.ability.extra.mult
            }
        end
    end,
        -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            for _, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_vampire") then
                    unlock_card(self)
                    break
                end
            end
        end
    end,
}