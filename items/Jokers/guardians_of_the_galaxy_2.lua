SMODS.Joker {
    key = "guardians_of_the_galaxy_2",
    order = 153,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 283995,
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
    k_genre = {"Sci-fi", "Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
       -- transform every planet into ego when you select a blind

        if context.ending_shop then
            for i, _card in ipairs(G.consumeables.cards) do
                if _card.ability.set == "Planet" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            _card:flip()
                            delay(0.1)
                            _card:set_ability("c_kino_ego")
                            _card:flip()
                            delay(0.1)
                            card_eval_status_text(_card, 'extra', nil, nil, nil,
                            { message = localize('k_guardians_2'), colour = G.C.LEGENDARY})
                            return true
                        end
                    }))
                end
            end
        end

    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].consumeable_usage and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_ego and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_ego.count or 0,
                20
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' and
        G.PROFILES[G.SETTINGS.profile].consumeable_usage and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_ego and G.PROFILES[G.SETTINGS.profile].consumeable_usage.c_kino_ego.count >= 20 then
            unlock_card(self)
        end
    end,
}

