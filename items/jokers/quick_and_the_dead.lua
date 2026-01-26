SMODS.Joker {
    key = "quick_and_the_dead",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            blind_lowering = 10
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 5, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 12106,
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
    k_genre = {"Action", "Western"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.blind_lowering
            }
        }
    end,
    enhancement_gate = "m_kino_action",
    kino_bullet_compat = true,
    calculate = function(self, card, context)
        -- When you select a blind, lower it by 10% for every Bullet
        if context.setting_blind and 
        card.counter and G.P_COUNTERS.counter_kino_bullet_joker and
        card.ability.counter and card.ability.counter.counter_num and card.ability.counter.counter_num > 0 then
            card:juice_up(0.8, 0.8)
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_kino_bang'), colour = G.C.BLACK })
            local _lower_amount = card.ability.extra.blind_lowering * card.ability.counter.counter_num
            Kino.lower_blind(_lower_amount)
            -- G.GAME.blind.chips = G.GAME.blind.chips * ((100 - _lower_amount) / 100)
            -- G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

            card:bb_increment_counter(-card.ability.counter.counter_num)
        end
    end
}