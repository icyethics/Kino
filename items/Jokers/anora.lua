SMODS.Joker {
    key = "anora",
    order = 144,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1064213,
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
    k_genre = {"Comedy", "Drama", "Romance"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you make a match, put an investment counter on every card held in hand
        if context.joker_main then
            local _romance_cards = 0
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_romance') and not context.scoring_hand[i].debuff then
                    _romance_cards = _romance_cards + 1
                end
            end

            if _romance_cards == 2 then
                for _index, _pcard in ipairs(G.hand.cards) do
                    _pcard:bb_counter_apply("counter_money", card.ability.extra.money)
                end

            end
        end
    end,
        -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'bb_increment_money_counter' then
            if args.card and args.card.ability.counter.counter_num >= 5 then
                unlock_card(self)
            end
        end
    end,
}