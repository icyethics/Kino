SMODS.Joker {
    key = "point_break",
    order = 80,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 2,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 1},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1089,
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
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a pair, destroy a random card in your hand and gain mult equal to its rank.

        if context.before and context.cardarea == G.jokers 
        and context.scoring_name == "Pair" then
            local _card = pseudorandom_element(G.hand.cards)
            
            _card.marked_to_destroy_by_point_break = true

            for i, v in ipairs(context.scoring_hand) do
                v.ability.perma_mult = v.ability.perma_mult or 0
                v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.a_mult
                card_eval_status_text(v, 'extra', nil, nil, nil,
                { message = localize("k_upgrade_ex"), colour = G.C.MULT })
            end
        end

        if context.destroy_card and context.cardarea == G.hand then
            
            if context.destroy_card.marked_to_destroy_by_point_break then
                return {remove = true}
            end
        end
    end
}