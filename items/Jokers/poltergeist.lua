SMODS.Joker {
    key = "poltergeist",
    order = 114,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 609,
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
    enhancement_gate = 'm_kino_demonic',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_kino_demonic') and not context.other_card.debuffed then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = context.other_card
                }
            end
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
            local tally = 0
            for j = 1, #args.cards do
                if args.cards[j].config.center == G.P_CENTERS.m_kino_demonic then
                    tally = tally+1
                end
            end
            if tally >= 3 then 
                unlock_card(self)
            end
        end
    end,
}