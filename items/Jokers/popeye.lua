SMODS.Joker {
    key = "popeye",
    order = 229,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            powerboost = 1,
            right_joker = nil,
            right_joker_id = nil
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 0, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11335,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.powerboost * 100
            }
        }
    end,
    calculate = function(self, card, context)
        -- The joker to the right is 2x as strong
    end,
    update = function(self, card, dt)
        if G.jokers then
            -- Find and set own address
            local _mypos = nil
            for _, _joker in ipairs(G.jokers.cards) do
                if _joker == card then
                    _mypos = _
                end
            end

            if not _mypos then return end
            -- Check every joker. If pos =/= _ + 1, remove popeye boost, otherwise, set it
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker ~= card then
                    if _joker.ability.kino_popeyetarget == card.ID and _index ~= _mypos + 1 then
                        Blockbuster.reset_value_multiplication(_joker, "popeye")
                        _joker.ability.kino_popeyetarget = nil
                    end

                    if _index == _mypos + 1 and _joker.ability.kino_popeyetarget ~= card.ID then
                        Blockbuster.manipulate_value(_joker, "popeye", 1 + card.ability.extra.powerboost)
                        _joker.ability.kino_popeyetarget = card.ID
                    end
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
		for _index, _joker in ipairs(G.jokers.cards) do
            Blockbuster.reset_value_multiplication(_joker, "popeye")
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
            local _tally = 0
            for i, _joker in ipairs(G.jokers.cards) do
                if _joker.edition.key == "e_polychrome" then
                    _tally = _tally + 1
                end
            end

            if _tally >= 2 then
                unlock_card(self)
            end
        end
    end,
}