SMODS.Joker {
    key = "hard_eight",
    order = 211,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 2,
            cur_chance = 1,
            chance = 4
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 0, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8052,
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
    pools, k_genre = {"Crime"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.cur_chance, card.ability.extra.chance, "kino_card_destruction")
        return {
            vars = {
                card.ability.extra.money,
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.destroy_card  and context.cardarea == G.hand then
            if context.destroy_card:get_id() == 8 then
                -- if pseudorandom("hardeight") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
                if SMODS.pseudorandom_probability(card, 'kino_hardeight', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_card_destruction") then    
                    return {remove = true}
                end
            end
        end

        if context.after and context.cardarea == G.jokers then
            local _count = 0
            for _, _card in ipairs(G.hand.cards) do
                if _card:get_id() == 8 then
                    _count = _count + 1
                end
            end

            return {
                dollars = _count * card.ability.extra.money,
            }
        end
    end
}