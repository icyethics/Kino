SMODS.Joker {
    key = "cronos",
    order = 166,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 0,
            a_chips = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11655,
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
    is_vampire = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play a single card, drain half its rank and gain x5 chips for each rank drained
        if context.before
        and #context.full_hand == 1
        and not context.blueprint and not context.repetition then
            print("aloha + " .. #context.full_hand)
            local i_card = context.scoring_hand[1]
            local suit_prefix = string.sub(i_card.base.suit, 1, 1).."_"
            local rank = i_card.base.id
            local _halfrank = rank / 2

            if i_card.base.id == 2 then
                return {
                    
                }
            end

            card.ability.extra.chips = card.ability.extra.chips + (rank - _halfrank) *card.ability.extra.a_chips

            local _rank_suffix = tostring(_halfrank)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                i_card:juice_up(0.8, 0.5)
                card_eval_status_text(i_card, 'extra', nil, nil, nil,
                { message = localize('k_cronos'), colour = G.C.CHIPS })
                i_card:set_base(G.P_CARDS[suit_prefix.._rank_suffix])
                delay(0.23)
            return true end }))
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}