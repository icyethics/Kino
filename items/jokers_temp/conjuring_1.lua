SMODS.Joker {
    key = "conjuring_1",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            a_mult = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    can_be_sold = false,
    kino_joker = {
        id = 138843,
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
                card.ability.extra.a_mult,
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- This joker cannot be sold
        -- Destroy the first card drawn each round and gain +2 mult
        if context.first_hand_drawn then
            if #context.hand_drawn >= 1 then
                local _target = context.hand_drawn[1]

                if _target:can_calculate() then
                    SMODS.destroy_cards(_target)
                    card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
                end
                
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].consumeable_usage and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_witch and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_witch.count or 0,
                25
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' and
        G.PROFILES[G.SETTINGS.profile].consumeable_usage and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_witch and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_witch.count >= 25 then
            unlock_card(self)
        end
    end,
}