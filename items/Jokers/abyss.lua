SMODS.Joker {
    key = "abyss",
    order = 60,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 5,
            destroy_cards = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2756,
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
    pools, k_genre = {"Thriller", "Sci-fi"},
    is_water = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
        
        local _unscoring_cards = 0
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (_unscoring_cards * card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare") -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
                
        return {
            vars = {
                new_numerator,
                new_denominator,
                card.ability.extra.cur_chance
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards held in hand have a 0/4 chance to jumpscare, increased by 1 for each unscored card
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local _unscoring_cards =  #context.full_hand - #context.scoring_hand

            if SMODS.pseudorandom_probability(card, 'kino_abyss', (_unscoring_cards * card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare") then
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