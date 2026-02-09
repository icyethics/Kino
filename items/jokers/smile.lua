SMODS.Joker {
    key = "smile",
    order = 118,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    enhancement_gate = "m_kino_demonic",
    kino_joker = {
        id = 882598,
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
    k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Face cards aren't sacrificed, but do count towards sacrifice
            
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
        if args.type == 'round_win' then
            if G.GAME.kino_played_non_faces_this_round == false then
                unlock_card(self)
            end
        end
    end,
}