SMODS.Joker {
    key = "dinner_with_andre",
    order = 183,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 2, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 25468,
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
    k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center.set == 'confection'
        and not context.blueprint then
            card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
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
        if args.type == 'kino_consumable_used' then
            if G.GAME.confections_used then
                local _tally = 0
                if G.GAME.confections_used.all >= 10 then
                    unlock_card(self)
                end
            end
        end
    end,
}