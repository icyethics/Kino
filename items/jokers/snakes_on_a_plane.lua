SMODS.Joker {
    key = "snakes_on_a_plane",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            handsize = 3,
            active = false
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 326,
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
    k_genre = {"Action", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.handsize
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard then
            card.ability.extra.active = true
            card:juice_up()
            return {
                message = localize("k_kino_snakes_on_a_plane"),
                colour = G.C.FILTER
            }
        end

        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0)
        and card.ability.extra.active then
            card.ability.extra.active = false
            return {
                cards_to_draw = 3
            }
        end
        
    end,
    -- Unlock Functions
    unlocked = true,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {

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