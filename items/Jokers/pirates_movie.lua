SMODS.Joker {
    key = "pirates_movie",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_pirate = true,
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 3, y = 4},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 72197,
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
    k_genre = {"Animation", "Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- The Pirates! Band of Misfits
        -- When you use a consumable with a sell value higher than 1, create a copy of it with a sell value of 0
        if context.using_consumeable then
            local _target = context.consumeable 
            if _target and _target.sell_cost and _target.sell_cost > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local copied_card = copy_card(_target)
                        copied_card.ability.extra_value = -copied_card.sell_cost
                        copied_card:set_cost()
                        copied_card:add_to_deck()
                        G.consumeables:emplace(copied_card)
                        return true
                    end
                }))
                return { message = localize('k_duplicated_ex') }
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
            local _total_value = 0
            for i, _joker in ipairs(G.jokers.cards) do
                _total_value = _total_value + _joker.sell_cost
            end

            if _total_value >= 50 then
                unlock_card(self)
            end
        end
    end,
}