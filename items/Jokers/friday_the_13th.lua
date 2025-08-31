SMODS.Joker {
    key = "friday_the_13th",
    order = 160,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 4488,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_horror
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When your hand contains no face cards, turn a random card in hand into a Horror card
        if context.joker_main then
            local _nofaces = true
            for i, _card in ipairs(context.scoring_hand) do
                if _card:is_face() then
                    _nofaces = false
                    break
                end
            end

            if _nofaces then
                local _listofcards = {}
                for i, _card in ipairs(G.hand.cards) do
                    if _card.config.center == G.P_CENTERS.c_base then
                        _listofcards[#_listofcards + 1] = _card
                    end
                end

                if #_listofcards > 0 then
                    local _card = pseudorandom_element(_listofcards, pseudoseed("f13"))

                    _card:set_ability(G.P_CENTERS.m_kino_horror, nil, true)
                end
            end
        end
    
    end
}