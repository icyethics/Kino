SMODS.Joker {
    key = "star_wars_holiday",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            a_stacks = 1,
            threshold = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 74849,
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
    pools = {["kino_starwars"] = true}, 
    k_genre = {"Sci-fi", "Christmas"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.a_stacks,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain a stack when you defeat a blind or use a planet
        -- create a Star Wars joker for 5 stacks
        -- when you sell this
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.stacks = card.ability.extra.stacks + 1
        end

        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            card.ability.extra.stacks = card.ability.extra.stacks + 1
        end

        if context.selling_self then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local _cards = math.floor(card.ability.extra.stacks / card.ability.extra.threshold)
                local _jokers_to_create = math.min(_cards, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + _jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _ = 1, _jokers_to_create do
                            SMODS.add_card {
                                set = 'kino_starwars',
                                key_append = 'kino_sw_holiday'
                            }
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades.count or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _star_wars, _christmas
            for i, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_starwars") then
                    _star_wars = true
                end

                if is_genre(_joker, "Christmas") then
                    _christmas = true
                end
            end

            if _star_wars and _christmas then
                unlock_card(self)
            end
        end
    end,
}