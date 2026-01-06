SMODS.Joker {
    key = "mr_and_mrs_smith",
    order = 42,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 787,
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
    k_genre = {"Action", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        if context.scoring_name == "Pair" and 
        context.cardarea == G.play and context.repetition and not context.repetition_only then
            return {
                message = 'Again!',
                repetitions = card.ability.extra.repetitions,
                card = context.other_card
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
        if args.type == 'hand_contents' then
            local _tally = 0
            for j = 1, #args.cards do
                print("Testing cards for Mr and Mrs Smith")
                if args.cards[j].config.center == G.P_CENTERS.m_kino_romance then
                    _tally = _tally+1
                    print("Going up by 1")
                end
            end
            if #args.cards == 2 and _tally == 2 then 
                unlock_card(self)
            end
        end
    end,
}