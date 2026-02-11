SMODS.Joker {
    key = "marty_supreme",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 4, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1317288,
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
    k_genre = {"Sports"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If first hand of round contains exactly two cards
        -- Raise rank of leftmost by 1
        -- Lower rank of rightmost by 1
        if context.after and 
        context.cardarea == G.jokers and 
        G.GAME.current_round.hands_played == 0 and 
        #context.full_hand == 2 then
                
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    SMODS.modify_rank(context.full_hand[1], 1)
                    card_eval_status_text(context.full_hand[1], 'extra', nil, nil, nil,
                    { message = localize('k_kino_marty_supreme_1'), colour = G.C.FILTER })
                    delay(0.23)
                    SMODS.modify_rank(context.full_hand[2], -1)
                    card_eval_status_text(context.full_hand[2], 'extra', nil, nil, nil,
                    { message = localize('k_kino_marty_supreme_2'), colour = G.C.FILTER })
                    delay(0.23)
                return true end }))
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