SMODS.Joker {
    key = "spartacus",
    order = 50,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 967,
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
    k_genre = {"Historical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play only a single card on your final hand
        -- turn every card into a copy of it
        if context.after and context.full_hand and #context.full_hand == 1 and G.GAME.current_round.hands_left == 0 then
            local _basecard = context.full_hand[1]
            for i = 1, #G.hand.cards do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    local new_card = copy_card(_basecard, G.hand.cards[i])
                    new_card:juice_up()

                    local _number = pseudorandom_element({1,2,3}, pseudoseed("spartacus"))
                    card_eval_status_text(new_card, 'extra', nil, nil, nil,
                    { message = localize('k_spartacus_' .. _number), colour = G.C.MULT })
                return true end }))
            end
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
        if args.type == 'modify_deck' and G.GAME.round >= 2  then
            local _hash = {}
            local _hit_10 = false
            for i, _pcard in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(_pcard) and not SMODS.has_any_suit(_pcard) then
                    local _id = _pcard:get_id()
                    _hash[_pcard.base.suit] = _hash[_pcard.base.suit] or {}
                    _hash[_pcard.base.suit][tostring(_id)] = _hash[_pcard.base.suit][tostring(_id)] or 0
                    _hash[_pcard.base.suit][tostring(_id)] = _hash[_pcard.base.suit][tostring(_id)] + 1
                    if _hash[_pcard.base.suit][tostring(_id)] >= 10 then
                        _hit_10 = true
                        break
                    end
                end
            end

            if _hit_10 then
                unlock_card(self)
            end
        end
    end,
}