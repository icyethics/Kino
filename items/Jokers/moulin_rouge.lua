SMODS.Joker {
    key = "moulin_rouge",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            handsize_gain = 1
        }   
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 2, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 824,
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
    pools, k_genre = {"Romance", "Musical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.handsize_gain
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain an additional handsize for each unique suit drawn to hand

        if context.first_hand_drawn then
            local _suitcount = 0

            local _suits = SMODS.Suits
            local _suithash = {}
            for _index, _pcard in ipairs(context.hand_drawn) do
                for _suitname, _suitdata in pairs(_suits) do
                    if not _suithash[_suitname] and _pcard:is_suit(_suitname) then
                        _suitcount = _suitcount + 1
                        _suithash[_suitname] = true
                        break
                    end
                end
            end

            if _suitcount > 1 then
                local _handsize = _suitcount * card.ability.extra.handsize_gain
                G.hand:change_size(_handsize)
                G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + _handsize
                return {
                    message = localize("k_kino_moulin_rouge")
                }
            end
        end
    end
}