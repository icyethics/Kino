SMODS.Joker {
    key = "maltese_falcon",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 0, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 963,
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
    k_genre = {"Mystery"},
    enhancement_gate = "m_kino_mystery",

    loc_vars = function(self, info_queue, card)
        local _count = 0
        if G.playing_cards then
            for i, _pcard in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(_pcard, "m_kino_mystery") then
                    _count = _count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.money,
                _count
            }
        }
    end,
    calculate = function(self, card, context)
        -- $1 per mystery card in deck
    end,
    calc_dollar_bonus = function(self, card)

        local _count = 0
        for i, _pcard in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(_pcard, "m_kino_mystery") then
                _count = _count + 1
            end
        end
        
        -- Check for set money
        return _count * card.ability.extra.money
    end
}