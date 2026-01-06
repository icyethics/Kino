SMODS.Joker {
    key = "star_wars_vii",
    order = 336,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            factor = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 5, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 140607,
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
    k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.factor,
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) * card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        -- scoring cards give chips equal to the number of planets used
        if context.individual and context.cardarea == G.play then
            local _level = to_number(G.GAME.hands[context.scoring_name].level) * card.ability.extra.factor
            return {
                mult = _level
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
        if args.type == 'modify_jokers' then
            for i, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_starwars") and _joker.edition and _joker.edition.polychrome then
                    unlock_card(self)
                    break
                end
            end
        end
    end,
}