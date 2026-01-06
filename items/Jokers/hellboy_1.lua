SMODS.Joker {
    key = "hellboy_1",
    order = 240,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 30
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 5, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1487,
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
    k_genre = {"Superhero", "Fantasy"},
    enhancement_gate = "m_kino_demonic",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- demonic cards do not trigger. Gain +30 chips if a demonic card scores
        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end

        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_kino_demonic") then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
            return {
                message = localize("k_hellboy")
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_sacrifices_made or 0,
                20
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_sacrifices_made' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_sacrifices_made and G.PROFILES[G.SETTINGS.profile].career_stats.kino_sacrifices_made >= 20 then
                unlock_card(self)
            end
        end
    end,
}