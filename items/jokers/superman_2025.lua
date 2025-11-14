SMODS.Joker {
    key = "superman_2025",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            charges_non = 0,
            a_charge = 1,
            chips = 50,
            mult = 10,
            x_mult = 2,
            high_level_mult = 2,
            ascension_mult = 10,
            thresholds = {10, 20, 50, 200, 1000}
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 2, y = 2},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1061474,
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
    k_genre = {"Superhero"},

    loc_vars = function(self, info_queue, card)
        local _modifier = 1

        if card.ability.extra.charges_non >= 1000 then
            _modifier = 10
        elseif card.ability.extra.charges_non >= 200 then
            _modifier = 2
        end

        return {
            vars = {
                card.ability.extra.a_charge,
                card.ability.extra.charges_non,
                card.ability.extra.chips * _modifier,
                card.ability.extra.mult * _modifier,
                card.ability.extra.x_mult * _modifier,
                card.ability.extra.high_level_mult,
                card.ability.extra.ascension_mult,
                colours = {
                    card.ability.extra.charges_non >= 10 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.charges_non >= 20 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.charges_non >= 50 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.charges_non >= 200 and G.C.FILTER or G.C.INACTIVE,
                    card.ability.extra.charges_non >= 1000 and G.C.FILTER or G.C.INACTIVE,
                }
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain a charge whenever a heart is scored
        -- Half current stacks when no hearts scored

        -- Gain abilities based on current charges
        -- 10: +50 Chips
        -- 25: +10 Mult
        -- 50: x2 Mult
        -- 200: Gives 2x as much score
        -- 1000: Gives 5x as much score
        if context.before and context.scoring_hand then
            local _hearts_count = 0
            
            for _index, _pcard in ipairs(context.scoring_hand) do
                if _pcard:is_suit("Hearts") then
                    _hearts_count = _hearts_count + 1
                end
            end

            if _hearts_count == 0 then
                local _start_value = card.ability.extra.charges_non
                card.ability.extra.charges_non = math.floor(card.ability.extra.charges_non / 2)
                for _index, _value in ipairs(card.ability.extra.thresholds) do
                    if _start_value > _value and _value >= card.ability.extra.charges_non then
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_kino_superman2025_powerdown'), colour = G.C.BLACK})
                    end
                end
                
                return {
                    message = tostring(card.ability.extra.charges_non),
                    colour = G.C.BLACK
                }
            
            elseif _hearts_count > 0 then
                local _start_value = card.ability.extra.charges_non
                card.ability.extra.charges_non = card.ability.extra.charges_non + (card.ability.extra.a_charge * _hearts_count)
                
                for _index, _value in ipairs(card.ability.extra.thresholds) do
                    if _start_value < _value and _value <= card.ability.extra.charges_non then
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_kino_superman2025_powerup'), colour = G.C.FILTER})
                    end
                end
                
                return {
                    message = tostring(card.ability.extra.charges_non),
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main then
            local _returntable = {

            }
            local _modifier = 1

            if card.ability.extra.charges_non >= 1000 then
                _modifier = 10
            elseif card.ability.extra.charges_non >= 200 then
                _modifier = 2
            end

            if card.ability.extra.charges_non >= 10 then
                _returntable.chips = card.ability.extra.chips * _modifier
            end

            if card.ability.extra.charges_non >= 20 then
                _returntable.mult = card.ability.extra.mult * _modifier
            end

            if card.ability.extra.charges_non >= 50 then
                _returntable.x_mult = card.ability.extra.x_mult * _modifier
            end

            return _returntable
        end
    end
}