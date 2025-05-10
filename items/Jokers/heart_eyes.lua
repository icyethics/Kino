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
    enhancement_gate = "m_kino_romance",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_jump_scare", vars = {tostring(Kino.jump_scare_mult)}}
        return {
            vars = {
                card.ability.extra.cur_chance,
                card.ability.extra.chance
            }
        }
    end,
    calculate = function(self, card, context)
        -- Romance cards have a 1/3 chance to jump scare
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_kino_romance") then
            if pseudorandom('heart_eyes') < (G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance then
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