SMODS.Joker {
    key = "batmanvsuperman",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        is_superman = true,
        extra = {
            powerboost = 1,
            boosted_cards = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 209112,
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
    pools = {["kino_batman"] = true}, 
    k_genre = {"Superhero", "Action", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.powerboost * 100
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss then
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker.ID ~= card.ID and kino_quality_check(_joker, "is_batman") then
                    card.ability.extra.boosted_cards[_joker.ID] = 1 + card.ability.extra.powerboost
                    Blockbuster.manipulate_value(_joker, "batvsupe_" .. card.ID, 1 + card.ability.extra.powerboost)
                end
            end
        end
        
        if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
            for _index, _joker in ipairs(G.jokers.cards) do
                if card.ability.extra.boosted_cards[_joker.ID] then
                    Blockbuster.reset_value_multiplication(_joker, "batvsupe_" .. card.ID)
                end
            end
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
            local _batman, _superman
            for _, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, 'is_batman') then
                    _batman = true
                end
                if kino_quality_check(_joker, 'is_superman') then
                    _batman = true
                end
            end
        end
    end,
}