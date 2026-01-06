SMODS.Joker {
    key = "pirates_of_the_caribbean_3",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_pirate = true,
        extra = {
            a_chips = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 285,
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
   k_genre = {"Fantasy", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker.area == G.jokers then
            local _value = context.other_joker.sell_cost
            context.other_joker:juice_up()

            return {
                chips = (card.ability.extra.a_chips * _value),
                card = context.other_joker
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_unscored_cards_played or 0,
                300
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            for i, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_pirate") then
                    unlock_card(self)
                    break
                end
            end
        end
    end,
}