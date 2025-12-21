SMODS.Joker {
    key = "meet_the_parents",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_chips = 20
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 5, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1597,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Numbered Cards give +20 chips for each face card of a matching suit held in hand

        if context.individual and not context.other_card:is_face() and context.cardarea == G.play then
            
            local _total_chips = 0
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:is_face() then
                    for _suitname, _suitdata in pairs(SMODS.Suits) do
                        if _pcard:is_suit(_suitname) and context.other_card:is_suit(_suitname) then
                            _total_chips = _total_chips + card.ability.extra.a_chips     
                        end
                    end
                end 
            end

            if _total_chips > 0 then
                return {
                    chips = _total_chips
                }
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
            for i, _joker in ipairs(G.jokers.cards) do
                if has_cast(_joker, "ID_380") then
                    unlock_card(self)
                end
            end
        end
    end,
}