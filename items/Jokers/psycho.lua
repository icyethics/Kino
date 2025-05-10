SMODS.Joker {
    key = "psycho",
    order = 9,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance = 3,
            destroy_cards = {}
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 1 },
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 539,
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
    pools, k_genre = {"Horror", "Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
        return {
            vars = {
                G.GAME.probabilities.normal * 1,
                card.ability.extra.chance,
                Kino.jump_scare_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Queens jump scare 1/4
        if context.individual and context.cardarea == G.play and context.other_card.base.id == 12 then
            if pseudorandom('psycho') < (G.GAME.probabilities.normal) / card.ability.extra.chance then
                card.ability.extra.destroy_cards[#card.ability.extra.destroy_cards + 1] = context.other_card
                return {
                    x_mult = Kino.jump_scare_mult, 
                    message = localize('k_jump_scare'),
                    colour = HEX("372a2d"),
                    card = context.other_card
                }
            end
        end

        if context.destroying_card and #card.ability.extra.destroy_cards > 0 and not context.blueprint then
            for i, card in ipairs(card.ability.extra.destroy_cards) do
                if context.destroying_card == card then
                    return true
                end
            end
        end
    end
}