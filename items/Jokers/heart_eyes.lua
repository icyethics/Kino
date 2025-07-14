SMODS.Joker {
    key = "heart_eyes",
    order = 214,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 3,
            destroy_cards = {}
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 3, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1302916,
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
    pools, k_genre = {"Romance", "Horror"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- Hearts held in hand have a 1/3 chance to Jump Scare
        if context.individual and context.cardarea == G.hand and context.other_card:is_suit("Hearts") and not context.end_of_round then
            -- if pseudorandom('heart_eyes') < (card.ability.extra.cur_chance) / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_heart_eyes', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare") then
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