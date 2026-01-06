SMODS.Joker {
    key = "joker",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 0, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 475557,
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
    k_genre = {"Drama", "Thriller"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = true
        if G.jokers then
            for _index, _joker in pairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_batman") then
                    enhancement_gate = false
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        local _count = 0
        for _key, _content in pairs(G.GAME.seen_jokers) do
            if string.sub(_key, 1, 2) == "j_" then
                _count = _count + 1
            end
        end

        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult * _count
            }
        }
    end,
    calculate = function(self, card, context)
        -- For every unique joker seen, gain +1 mult
        if context.joker_main then
            local _count = 0
            for _key, _content in pairs(G.GAME.seen_jokers) do
                if string.sub(_key, 1, 2) == "j_" then
                    _count = _count + 1
                end
            end

            return {
                mult = card.ability.extra.mult * _count
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
        if args.type == 'kino_add_to_deck' then
            print("Joker check")
            print(args.card.config.center == G.P_CENTERS.j_joker)
            if args.card.config.center == G.P_CENTERS.j_joker then
                unlock_card(self)
            end
        end
    end,
}