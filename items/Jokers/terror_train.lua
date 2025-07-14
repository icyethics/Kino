SMODS.Joker {
    key = "terror_train",
    order = 109,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance = 2,
            cur_chance = 1,
            a_chance = 1,
            destroy_cards = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 0, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 40969,
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

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
    
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_levelup")
        return {
            vars = {
                new_numerator,
                new_denominator,
                Kino.jump_scare_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards that share a rank with scoring cards have a 1/3 chance to Jumpscare

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local _rankmatch = false

            for _index, _pcard in ipairs(context.scoring_hand) do
                if _pcard:get_id() == context.other_card:get_id() then
                    _rankmatch = true
                end
            end
            
            if _rankmatch and
            SMODS.pseudorandom_probability(card, 'kino_terror_train', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare") then
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