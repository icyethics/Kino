SMODS.Joker {
    key = "batman_killing_joke",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 3, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 382322,
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
    k_genre = {"Superhero", "Animation", "Thriller"},

    loc_vars = function(self, info_queue, card)

        local _count = 0
        if G.jokers then
            _count = G.jokers.config.card_limit - #G.jokers.cards
            for _index, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_batman") then
                    _count = _count + 1
                end
            end
        end

        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips * (2 ^ _count)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _count = G.jokers.config.card_limit - #G.jokers.cards
            for _index, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_batman") then
                    _count = _count + 1
                end
            end

            return {
                chips = card.ability.extra.chips * (2 ^ _count)
            }
        end
    end
}