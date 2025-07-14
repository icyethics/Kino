SMODS.Joker {
    key = "demolition_man",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 2, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9739,
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
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
       -- If your first discard of the round is a single card
       -- Destroy it and upgrade every card in hand with +2 mult 
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.discard and not context.blueprint and
            G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
            for _index, _pcard in ipairs(G.hand) do
                if _pcard ~= context.full_hand[1] then
                    _pcard.ability.perma_mult = _pcard.ability.perma_mult or 0
                    _pcard.ability.perma_mult = _pcard.ability.perma_mult + card.ability.extra.a_mult
                end
            end
        end
    end
}