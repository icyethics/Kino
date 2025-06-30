SMODS.Joker {
    key = "jaws",
    order = 11,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 50
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 1 },
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 578,
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
    is_water = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Unscored cards give +30 chips
        -- and get debuffed
        if context.individual and context.cardarea == "unscored" then
            local _card = context.other_card
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                _card:juice_up()
                card_eval_status_text(_card, 'extra', nil, nil, nil,
                { message = localize('k_jaws'), colour = G.C.BLACK })
                SMODS.debuff_card(_card, true, card.config.center.key)
            return true end }))

            return {
                chips = card.ability.extra.chips,
                card = context.other_card
            }
        end
    end
}