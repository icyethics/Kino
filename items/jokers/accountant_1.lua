SMODS.Joker {
    key = "accountant_1",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 3, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 302946,
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
    k_genre = {"Action", "Crime"},
    enhancement_gate = "m_kino_action",
    kino_bullet_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- When Loaded: Earn $1 per Bullet, then consume 1 Bullet

        if context.joker_main and card.counter and card.counter == "counter_kino_bullet" and
        card.ability.counter and card.ability.counter.counter_num and card.ability.counter.counter_num > 0 then
            local _money = card.ability.counter.counter_num * card.ability.extra.money

            card:bb_increment_counter(-1)

            return {
                money = _money
            }

        end
    end,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_bullets_loaded or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'load_bullet' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_bullets_loaded and G.PROFILES[G.SETTINGS.profile].career_stats.kino_bullets_loaded >= 50 then
                unlock_card(self)
            end
        end
    end, 
}