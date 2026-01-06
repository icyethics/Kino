SMODS.Joker {
    key = "shinkamenrider",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_xmult = 1,
            a_xmult = 0.5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 3, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 813477,
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
    k_genre = {"Superhero", "Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_xmult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
            card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end

        if context.joker_main and card.ability.extra.stacked_xmult > 1 then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }    
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.kino_boss_mode.Big = true
        G.GAME.kino_boss_mode_odds.Big = 0.5
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
            G.GAME.kino_boss_mode.Big = false
            G.GAME.kino_boss_mode_odds.Big = 0
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_boss_blind_defeated or 0,
                100
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_boss_blind_defeated' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_boss_blind_defeated and G.PROFILES[G.SETTINGS.profile].career_stats.kino_boss_blind_defeated >= 100 then
                unlock_card(self)
            end
        end
    end,
}