SMODS.Joker {
    key = "annabelle",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 3, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 250546,
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
    k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
    
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "kino_jumpscare")
        return {
            vars = {
                new_numerator,
                new_denominator,
                Kino.jump_scare_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards of rank 5 and below have a rank in 5 chance to jumpscare
        if context.individual and context.cardarea == G.hand and context.other_card:get_id() <= 5 and not context.end_of_round then
            if SMODS.pseudorandom_probability(card, 'kino_annabelle', context.other_card:get_id(), card.ability.extra.chance, "kino_jumpscare") then
                local x_mult = Kino.jumpscare(context.other_card)
                return {
                    x_mult = x_mult, 
                    message = localize('k_jump_scare'),
                    colour = HEX("372a2d"),
                    card = context.other_card
                }
            end
        end
    end
}