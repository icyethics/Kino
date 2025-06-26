SMODS.Joker {
    key = "titanic",
    order = 18,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            starting_amount = 13,
            mult = 0,
            a_mult = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 3},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 597,
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
    pools, k_genre = {"Romance"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local suit_count = 0 
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.config.card.suit == "Hearts" and v.config.center ~= G.P_CENTERS.m_stone then
                    suit_count = suit_count + 1
                end
            end
        end

        return suit_count >= 14 and true or false
    end,

    loc_vars = function(self, info_queue, card)

        local _starting_suits = G.GAME.suit_startingcounts and G.GAME.suit_startingcounts["Hearts"] or 13
        local suit_count = 0 
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.config.card.suit == "Hearts" and v.config.center ~= G.P_CENTERS.m_stone then
                    suit_count = suit_count + 1
                end
            end
        end
        return {
            vars = {
                _starting_suits,
                card.ability.extra.a_mult,
                math.max((suit_count - _starting_suits) * card.ability.extra.a_mult, 0)
            }
        }
    end,
    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play then
            local suit_count = 0 
            for k, v in pairs(G.playing_cards) do
                if v.config.card.suit == "Hearts" and v.config.center ~= G.P_CENTERS.m_stone then
                    suit_count = suit_count + 1
                end
            end
            card.ability.extra.mult = math.max((suit_count - G.GAME.suit_startingcounts["Hearts"]) * card.ability.extra.a_mult, 0)

            if context.other_card:is_suit("Hearts") then
                return {
                    mult = card.ability.extra.mult,
                    card = context.other_card
                }
            end
        end
    end
}