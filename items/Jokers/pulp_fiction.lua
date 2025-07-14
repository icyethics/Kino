SMODS.Joker {
    key = "pulp_fiction",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            a_chance_non = 1,
            chance = 100,
            --
            stacked_mult = 0,
            a_mult = 1,
            aa_mult = 1,
            reset_mult_non = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 5, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 680,
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
    pools, k_genre = {"Drama", "Crime"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_reset")
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.aa_mult,
                card.ability.extra.stacked_mult,
                new_numerator,
                new_denominator,
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever you use a consumable
        -- gain +1 mult and increase scaling by 1
        -- 1/100 chance to reset this joker
        -- increase odds by 1 whenever you use a consumable

        if context.using_consumeable and context.cardarea == G.jokers then
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
            card.ability.extra.a_mult = card.ability.extra.a_mult + card.ability.extra.aa_mult

            -- chances
            -- if pseudorandom("kino_pulpfic") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
            if SMODS.pseudorandom_probability(card, 'kino_pulpfic', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_reset") then
                card.ability.extra.stacked_mult = 0
                card.ability.extra.a_mult = card.ability.extra.reset_mult_non
                card.ability.extra.cur_chance = 1

                return {
                    message = localize("k_kino_pulp_fiction")
                }
            else
                card.ability.extra.cur_chance = card.ability.extra.cur_chance + 1
            end 
        end

        if context.joker_main and card.ability.extra.stacked_mult > 0 then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}