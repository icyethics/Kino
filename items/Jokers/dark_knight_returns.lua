SMODS.Joker {
    key = "dark_knight_returns",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            a_levels = 1,
            mult = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 5, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 49026,
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
        
        local _count = 0

        if G.jokers then
            _count = G.jokers.config.card_limit - #G.jokers.cards
            for i = 1, #G.jokers.cards do
                if kino_quality_check(G.jokers.cards[i], "is_batman") then 
                    _count = _count + 1
                end
            end
        end
        
        return {
            vars = {
                _count,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local _count = G.jokers.config.card_limit - #G.jokers.cards
            for i = 1, #G.jokers.cards do
                if kino_quality_check(G.jokers.cards[i], "is_batman") then 
                    _count = _count + 1
                end
            end

            for i = 1, _count do
                local _hand = get_random_hand()
                upgrade_hand(card, _hand, nil, card.ability.extra.mult)
                update_hand_text(
                    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
                    { mult = 0, chips = 0, handname = "", level = "" }
                )
                -- level_up_hand
                -- SMODS.smart_level_up_hand(context.blueprint_card or card, _hand, nil, card.ability.extra.a_levels)
            end
        end
    end
}