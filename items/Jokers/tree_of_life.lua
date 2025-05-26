SMODS.Joker {
    key = "tree_of_life",
    order = 239,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 20
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 4, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8967,
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
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _hash = {}
            local _count = 0
            for _, _card in ipairs(G.hand.cards) do
                local _id = _card.overrides_base_rank and 0 or _card:get_id()

                if not _hash[_id] then
                    _hash[_id] = true
                    _count = _count + 1
                end
            end

            return {
                chips = card.ability.extra.chips * _count
            }
        end
    end
}