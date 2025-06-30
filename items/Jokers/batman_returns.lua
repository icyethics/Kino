SMODS.Joker {
    key = "batman_returns",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            joker_slots = 1,
            threshold = 2,
            additional_slots_non = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 3, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 364,
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
    k_genre = {"Superhero", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.joker_slots,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        
    end,
    update = function(self, card, dt)
        -- count all joker slots
        if card.area and card.area == G.jokers then
            local _count = 0
            for _index, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_batman") then
                    _count = _count + 1
                end
            end

            _count = math.floor(_count / 2)

            if card.ability.extra.additional_slots_non ~= _count then
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.additional_slots_non
                card.ability.extra.additional_slots_non = _count
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.additional_slots_non
            end
        end
    end
}