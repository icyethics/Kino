SMODS.Joker {
    key = "scarface_2",
    order = 265,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 0, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1893,
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
    k_genre = {"Crime"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_crime
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- when you use a consumable, change one random card in deck into a crime card
        if context.using_consumeable then

            -- get targets
            local _valid_targets = {}
            for _, _pcard in ipairs(G.playing_cards) do
                if _pcard.config.center == G.P_CENTERS.c_base then
                    _valid_targets[#_valid_targets + 1] = _pcard
                end
            end

            -- set target
            if #_valid_targets > 0 then
                local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_scarface_2"))

                _target:set_ability("m_kino_crime", nil, true)
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].consumeable_usage and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_gangster and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_gangster.count or 0,
                10
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' and
        G.PROFILES[G.SETTINGS.profile].consumeable_usage and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_gangster and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_gangster.count >= 10 then
            unlock_card(self)
        end
    end,
}