SMODS.Joker {
    key = "big_short",
    order = 34,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            earned = 1,
            earned_per_non = 5,
            cur_chance = 1,
            double_chance_non = 20,
            destroy_chance_non = 10,
            destroy_floor_non = 1,
            destroy_increment = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 318846,
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
        info_queue[#info_queue+1] = {set = 'Other', key = "bust_econ"}

        local new_numerator_doubling, new_denominator_doubling = SMODS.get_probability_vars(card, (card.ability.extra.destroy_floor_non), card.ability.extra.destroy_chance_non, "kino_money_loss") 
        local new_numerator_busting, new_denominator_busting = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.double_chance_non, "kino_money_generation")  
        return {
            
            vars = {
                card.ability.extra.earned,
                card.ability.extra.earned_per_non,
                new_numerator_doubling,
                new_denominator_doubling,
                new_numerator_busting,
                new_denominator_busting,
                card.ability.extra.destroy_increment,
            }
        }
    end,
    calc_dollar_bonus = function(self, card)
        local money = 0

        -- Check for set money
        -- if pseudorandom('big_short') < (card.ability.extra.destroy_floor_non) / card.ability.extra.destroy_chance_non then
        if SMODS.pseudorandom_probability(card, 'kino_big_short', (card.ability.extra.destroy_floor_non), card.ability.extra.destroy_chance_non, "kino_money_loss") then
            G.GAME.dollars = 0
        end

        card.ability.extra.destroy_floor_non = card.ability.extra.destroy_floor_non + card.ability.extra.destroy_increment

        money = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.earned_per_non) * 1

        -- Check for the doubling bonus
        -- if pseudorandom('big_short') < G.GAME.probabilities.normal / card.ability.extra.double_chance_non then
        if SMODS.pseudorandom_probability(card, 'kino_big_short', (card.ability.extra.cur_chance), card.ability.extra.double_chance_non, "kino_money_generation") then
            money = G.GAME.dollars
        end
        
        -- Check for set money
        return money
    end
}