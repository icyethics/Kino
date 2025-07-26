SMODS.Joker {
    key = "star_wars_clone_wars",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 1, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Sci-fi", "Animation"},

    loc_vars = function(self, info_queue, card)
        local _mypos = nil
        local _count = 0
        local _retriggers = 0

        if G.jokers then
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker == card then
                    _mypos = _index
                end
                if is_genre(_joker, "Animation") then
                    _count = _count + 1
                end
            end

            if _mypos then
                if G.jokers.cards[_mypos - 1] and is_genre(G.jokers.cards[_mypos - 1], "Sci-fi") then
                    _retriggers = _retriggers + 1
                end
                if G.jokers.cards[_mypos + 1] and is_genre(G.jokers.cards[_mypos + 1], "Sci-fi") then
                    _retriggers = _retriggers + 1
                end
            end
        end

        local _mult = card.ability.extra.mult * _count
        return {
            vars = {
                card.ability.extra.mult,
                _mult,
                1,
                _retriggers
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives +5 Mult for each animation joker you have
        -- Triggers +1 times per adjacent Sci-fi joker
        if context.retrigger_joker_check and context.other_card == card then
            local _mypos = nil
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker == card then
                    _mypos = _index
                end
            end

            local _retriggers = 0

            if G.jokers.cards[_mypos - 1] and is_genre(G.jokers.cards[_mypos - 1], "Sci-fi") then
                _retriggers = _retriggers + 1
            end
            if G.jokers.cards[_mypos + 1] and is_genre(G.jokers.cards[_mypos + 1], "Sci-fi") then
                _retriggers = _retriggers + 1
            end

            return {
                message = localize("k_again_ex"),
                repetitions = _retriggers
            }
        end

        if context.joker_main then
            local _count = 0
            for _index, _joker in ipairs(G.jokers.cards) do
                if is_genre(_joker, "Animation") then
                    _count = _count + 1
                end
            end
            local _mult = card.ability.extra.mult * _count
            return {
                mult = _mult
            }
        end
    end
}