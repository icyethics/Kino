SMODS.Joker {
    key = "benjamin_button",
    order = 78,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 0},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 4922,
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
    pools, k_genre = {"Drama", "Fantasy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand and context.cardarea == G.jokers then
            -- iterate through scoring hand
            for i = 1, #context.scoring_hand do
                local i_card = context.scoring_hand[i]
                local suit_prefix = string.sub(i_card.base.suit, 1, 1).."_"
                local rank_suffix = i_card.base.id == 2 and 14 or math.max(2, i_card.base.id-1)

                if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                elseif rank_suffix == 10 then rank_suffix = 'T'
                elseif rank_suffix == 11 then rank_suffix = 'J'
                elseif rank_suffix == 12 then rank_suffix = 'Q'
                elseif rank_suffix == 13 then rank_suffix = 'K'
                elseif rank_suffix == 14 then rank_suffix = 'A'
                end

                

                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    i_card:juice_up(0.8, 0.5)
                    card_eval_status_text(i_card, 'extra', nil, nil, nil,
                    { message = localize('k_benjamin_button'), colour = G.C.CHIPS })
                    i_card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    delay(0.23)
                return true end }))
                
                
            end
        end
    end
}