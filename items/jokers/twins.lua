SMODS.Joker {
    key = "twins",
    order = 70,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 25,
            mult = 25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9493,
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
    k_genre = {"Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- if your hand contains no more than 2 cards, gain 30 chips and 30 mult
        if context.joker_main and context.full_hand and #context.full_hand == 2 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
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
        if args.type == 'win' then
            local _hash = {}
            for i, _joker in ipairs(G.jokers.cards) do
                local _key = _joker.config.center.key
                if _hash[_key] then
                    unlock_card(self)
                    break
                else
                    _hash[_key] = true
                end
            end
        end
    end,
}