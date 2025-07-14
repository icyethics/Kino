SMODS.Joker {
    key = "to_kill_a_mockingbird",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_9",
    pos = { x = 1, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 595,
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
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 
        (card.ability.extra.cur_chance), 
        card.ability.extra.chance, 
        "kino_joker_manipulation")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a joker is destroyed, 1/3 chance to make it a Negative instead
        -- Does not work on itself
        if context.joker_type_destroyed then
            if context.card.ability.set == "Joker" and context.card ~= card then
                if SMODS.pseudorandom_probability(card, 'kino_mockingbird', 
                (card.ability.extra.cur_chance), 
                card.ability.extra.chance, 
                "kino_joker_manipulation") then
                    local _card = context.card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:juice_up()
                            _card:set_edition({negative = true}, true)
                            card_eval_status_text(_card, 'extra', nil, nil, nil,
                            { message = localize('k_kino_saved'), colour = G.C.PURPLE})
                            return true
                        end
                    }))
                    return {
                        no_destroy = true
                    }
                end
            end
        end
    end
}