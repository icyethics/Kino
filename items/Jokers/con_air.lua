SMODS.Joker {
    key = "con_air",
    order = 291,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 2, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1701,
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
    k_genre = {"Action"},
    enhancement_gate = "m_kino_crime",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- retrigger the first playing card once for each scoring Crime card
        if context.cardarea == G.play and context.repetition and context.other_card == context.scoring_hand[1] then
            local _reps = 0
            for _, _pcard in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(_pcard, "m_kino_crime") then
                    _reps = _reps + card.ability.extra.repetitions
                end
            end

            return {
                repetitions = _reps,
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
            for i, _joker in ipairs(G.jokers.cards) do
                if has_cast(_joker, "ID_2963") then
                    unlock_card(self)
                end
            end
        end
    end,
}