SMODS.Joker {
    key = "dr_strangelove",
    order = 49,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            hand_name = "Flush",
            x_mult = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 0, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 935,
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
    pools, k_genre = {"Comedy", "War"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_name,
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Each round, choose a random hand type.
        -- If you play this hand type: BLOW IT UP (x5 and destroy all cards played and in hand.)
        if context.end_of_round and not context.blueprint then

            local _poker_hands = {}
            local cur_hand = card.ability.extra.hand_name

            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands+1] = k end
            end
            
            card.ability.extra.hand_name = nil

            while not card.ability.extra.hand_name do
                card.ability.extra.hand_name = pseudorandom_element(_poker_hands)
                if card.ability.extra.hand_name == cur_hand then
                    card.ability.extra.hand_name = nil
                end
            end
        end

        if context.joker_main and context.scoring_name == card.ability.extra.hand_name then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        if context.destroying_card and context.scoring_name == card.ability.extra.hand_name 
        and not context.blueprint then
            return true
		end
    end
}