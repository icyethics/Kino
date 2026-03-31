SMODS.Joker {
    key = "frankenstein",
    order = 99,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            active_blueprint_check = false,
            active = true,
            chips = 0,
            mult = 0,
            xmult = 1,
            dollars = 0,
            xchips = 1,
            factor = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 3035,
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
    k_genre = {"Horror", "Fantasy"},

    loc_vars = function(self, info_queue, card)


        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult,
                card.ability.extra.dollars,
                card.ability.extra.xchips,
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card is destroyed, gain bonuses based on its suit
        -- OLD EFFECT
        -- if context.remove_playing_cards and not context.blueprint then
        --     for _, _pcard in ipairs(context.removed) do
        --         local _suits = SMODS.Suits
        --         for _suitname, _suitdata in pairs(_suits) do
        --             if _pcard:is_suit(_suitname) then
        --                 if _suitname == 'Diamonds' then
        --                     card.ability.extra.dollars = card.ability.extra.dollars + (card.ability.extra.factor / 2)
        --                 elseif _suitname == 'Hearts' then
        --                     card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.factor * 0.1)
        --                 elseif _suitname == 'Spades' then
        --                     card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.factor * 3)
        --                 elseif _suitname == 'Clubs' then
        --                     card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.factor)
        --                 else
        --                     card.ability.extra.xchips = card.ability.extra.xchips + (card.ability.extra.factor * 0.1)
        --                 end
        --             end
        --         end
        --     end
        -- end

        -- if context.joker_main then
        --     return {
        --         dollars = card.ability.extra.dollars,
        --         chips = card.ability.extra.chips,
        --         mult = card.ability.extra.mult,
        --         x_mult = card.ability.extra.xmult,
        --         x_chips = card.ability.extra.xchips
        --     }
        -- end

        if context.remove_playing_cards and 
        card.ability.extra.active and
        context.removed and #context.removed > 0 then
            local _target = context.removed[1]
            local _newcard = copy_card(_target)
            _newcard.states.visible = nil

            local _possible_upgrades = {
                -- Mult (4/10) -- 50%, 35%, 15%
                perma_mult = {1, 3, 5},
                -- Chips (3/10)
                perma_bonus = {5, 25, 40},
                -- Xmult (2/10)
                perma_x_mult = {0.1, 0.3, 0.5},
                -- Retriggers (1/10)
                bonus_repetitions = {1, 1, 2}
            }

            local _rand_1 = pseudorandom("frankenstein") -- Which bonus
            local _rand_2 = pseudorandom("frankenstein_2") -- Value of bonus
            local _val = 1
            -- Roll value
            if _rand_2 < 0.15 then
                _val = 3
            elseif _rand_2 < 0.5 then
                _val = 2
            end


            if _rand_1 < 0.1 then
                _newcard.ability["bonus_repetitions"] = _newcard.ability["bonus_repetitions"] or 0
                _newcard.ability["bonus_repetitions"] = _newcard.ability["bonus_repetitions"] + _possible_upgrades.bonus_repetitions[_val]
            elseif _rand_1 < 0.3 then
                _newcard.ability["perma_x_mult"] = _newcard.ability["perma_x_mult"] or 1
                _newcard.ability["perma_x_mult"] = _newcard.ability["perma_x_mult"] + _possible_upgrades.perma_x_mult[_val]
            elseif _rand_1 < 0.6 then
                _newcard.ability["perma_bonus"] = _newcard.ability["perma_bonus"] or 0
                _newcard.ability["perma_bonus"] = _newcard.ability["perma_bonus"] + _possible_upgrades.perma_bonus[_val]
            else
                _newcard.ability["perma_mult"] = _newcard.ability["perma_mult"] or 0
                _newcard.ability["perma_mult"] = _newcard.ability["perma_mult"] + _possible_upgrades.perma_mult[_val]
            end

            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    _newcard:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _newcard)
                    G.deck:emplace(_newcard)
                    _newcard:start_materialize()
                    return true
                end
            }))

            card.ability.extra.active = false
        end

        if context.setting_blind then
            card.ability.extra.active = true

            local eval = function(card) return card.ability.extra.active end
            juice_card_until(card, eval, true)
        end
    end
}