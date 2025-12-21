SMODS.Joker {
    key = "nightmare_before_christmas",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            retriggers = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 2, y = 1},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9479,
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
    k_genre = {"Musical", "Animation", "Christmas"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers
            }
        }
    end,
    calculate = function(self, card, context)
        -- Horror jokers that are adjacent to Christmas jokers retrigger

        if context.retrigger_joker_check and is_genre(context.other_card, "Horror") then
            -- Find location 
            local coord = nil
            for i, _joker in ipairs(G.jokers.cards) do
                if _joker == context.other_card then
                    coord = i
                end
            end

            if coord then
                if (G.jokers.cards[coord - 1] and is_genre(G.jokers.cards[coord - 1], "Christmas")) or
                (G.jokers.cards[coord + 1] and is_genre(G.jokers.cards[coord + 1], "Christmas")) then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = card.ability.extra.retriggers
                    }
                end
            end
        end

    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades.count or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _horror, _christmas 
            for i, _joker in ipairs(G.jokers.cards) do
                if is_genre(_joker, "Horror") then
                    _horror = true
                elseif is_genre(_joker, "Christmas") then
                    _christmas = true
                end
            end

            if _horror and _christmas then
                unlock_card(self)
            end
        end
    end,
}