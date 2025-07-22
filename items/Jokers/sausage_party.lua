SMODS.Joker {
    key = "sausage_party",
    order = 332,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 1, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 223702,
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
    pools, k_genre = {"Comedy", "Animation"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_levelup")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- whenever a confection triggers, 1/3 chance to upgrade a random hand
        if context.confection_used then
            -- if pseudorandom("kino_sauspart") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_sausauge_party', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_levelup") then    
                local handtype = get_random_hand()
                -- level_up_hand
                SMODS.smart_level_up_hand(context.blueprint_card or card, handtype, nil, 1)
                card:juice_up()
            end
        end
    end
}