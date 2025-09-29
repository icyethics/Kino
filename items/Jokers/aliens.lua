SMODS.Joker {
    key = "aliens",
    order = 59,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_debuffing_non = 2,
            x_mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 679,
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
    pools, k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_debuffing_non,
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- X2 mult, but debuffs two random cards when triggered.
        if context.joker_main then
            local _cards_debuffed = 0
            local _valid_targets = {}

            for _index, _pcard in ipairs(G.deck.cards) do
                if _pcard.debuff == false then
                    _valid_targets[#_valid_targets +1] = _pcard
                end
            end

            if #_valid_targets > 0 then
                for i = 1, math.min(card.ability.extra.cards_debuffing_non, #_valid_targets) do
                    print(i)
                    local _rand_card = pseudorandom_element(G.deck.cards,  pseudoseed('aliens'))
                    if _rand_card.debuff == false then
                        SMODS.debuff_card(_rand_card, true, card.config.center.key)
                        _cards_debuffed = _cards_debuffed + 1
                    end
                end
            end

            return {
                x_mult = card.ability.extra.x_mult,
            }
        end
    end
}