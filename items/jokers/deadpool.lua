SMODS.Joker {
    key = "deadpool",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            timer = 0,
            chips_rate_per_second = 2 
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 1, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 293660,
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
    k_genre = {"Superhero", "Comedy"},

    loc_vars = function(self, info_queue, card)
        local main_end = {
            {n=G.UIT.T, config={text = '  +',colour = G.C.CHIPS, scale = 0.32}},
            {n=G.UIT.O, config={object = DynaText({
                string = {{prefix = "", ref_table = card.ability.extra, ref_value = 'timer'}}, 
                colours = {G.C.CHIPS},
                bump = true,
                pop_in_rate = 0, 
                silent = true, 
                pop_delay = 0.5, 
                scale = 0.32, 
                min_cycle_time = 0})}},
            {n=G.UIT.T, config={text = ' Chips',colour = G.C.UI.TEXT_DARK, scale = 0.32}},
        }
        return {
            vars = {

            },
            main_end = main_end
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.timer
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