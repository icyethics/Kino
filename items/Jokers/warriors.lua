SMODS.Joker {
    key = "warriors",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 1, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11474,
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
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards give +2 mult for each card that shares a suit held in hand
        if context.individual and context.cardarea == G.play then
            local _count = 0
            for _index, _pcard in ipairs(G.hand.cards) do
                local _suits = SMODS.Suits
                for _suitname, _suitdata in pairs(_suits) do
                    if _pcard:is_suit(_suitname) then
                        _count = _count + 1
                        break
                    end
                end
            end

            return {
                mult = _count * card.ability.extra.mult
            }
        end
    end
}