SMODS.Joker {
    key = "ready_player_one",
    order = 98,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 333339,
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
    k_genre = {"Sci-fi", "Adventure"},
    in_pool = function(self, args)
        -- Check for the right frequency
        if G.jokers and G.jokers.cards then
            for k, v in pairs(G.jokers.cards) do
                local _joker_date = Card:get_release(v)

                if _joker_date and (_joker_date[1] >= 1970 and _joker_date[1] <= 1989) then
                    return true
                end
            end
        end

        return false
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- Jokers from the 70s and 80s give chips equal to their release year
        if context.other_joker and context.other_joker.config.center.kino_joker then
            local _joker_date = Card:get_release(context.other_joker)

            if _joker_date[1] >= 1970 and _joker_date[1] <= 1989 then
                return {
                    chips = _joker_date[1] - 1900
                }
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
        if args.type == 'kino_add_to_deck' then
            local _tally = 0
            for i, _joker in ipairs(G.jokers.cards) do
                if _joker.config.center.kino_joker then
                    local _joker_date = Card:get_release(_joker)
                    if _joker_date[1] >= 1970 and _joker_date[1] <= 1989 then
                        _tally = _tally + 1
                    end
                end
            end
            
            if _tally >= 3 then
                unlock_card(self)
            end
        end
    end,
}