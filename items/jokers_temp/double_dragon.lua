SMODS.Joker {
    key = "double_dragon",
    order = 243,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 50
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 2, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2436,
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
    k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _ranks = {}
            for _, _card in ipairs(G.hand.cards) do
                local _rank1 = _card:get_id()

                if not _ranks[_rank1] then
                    _ranks[_rank1] = 0
                end
                _ranks[_rank1] = _ranks[_rank1] + 1

            end

            local _chips = 0
            for _rank, _count in pairs(_ranks) do
                if _count >= 2 then
                    _chips = _chips + card.ability.extra.chips
                end
            end

            return {
                chips = _chips
            }
        end
    end
}