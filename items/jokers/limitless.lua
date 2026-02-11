SMODS.Joker {
    key = "limitless",
    order = 267,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            increase = 20
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 51876,
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
    k_genre = {"Crime", "Thriller"},
    enhancement_gate = 'm_kino_crime',

    loc_vars = function(self, info_queue, card)
        
        return {
            vars = {
                card.ability.extra.increase,
                G.GAME.money_stolen,
                G.GAME.money_stolen * (card.ability.extra.increase / 100)
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever you defeat a blind, increase money stolen by 20%
        if context.end_of_round and context.cardarea == G.jokers then
            local _increase = G.GAME.money_stolen * (card.ability.extra.increase / 100)

            Kino:increase_money_stolen(_increase)

            return {
                message = localize('k_upgrade_ex'), 
                colour = G.C.MONEY
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_crime_card_earned or 0,
                100
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_crime_card_earned and G.PROFILES[G.SETTINGS.profile].career_stats.kino_crime_card_earned >= 100 then
                unlock_card(self)
            end
        end
    end,
}

