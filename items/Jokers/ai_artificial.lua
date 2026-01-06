SMODS.Joker {
    key = "ai_artificial",
    order = 88,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 1,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 644,
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
    k_genre = {"Sci-fi"},
    enhancement_gate = 'm_kino_sci_fi',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.a_mult * G.GAME.current_round.sci_fi_upgrades
            }
        }
    end,
    calculate = function(self, card, context)
        -- gain 1 mult for every time a sci-fi card has been upgraded.
        if context.joker_main then
            local _mult = card.ability.extra.a_mult * G.GAME.current_round.sci_fi_upgrades
            return {
                mult = _mult
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_sci_fi_upgrades' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades >= 50 then
                unlock_card(self)
            end
        end
    end,
}