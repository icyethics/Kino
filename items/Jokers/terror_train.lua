SMODS.Joker {
    key = "terror_train",
    order = 109,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance = 10,
            total_chance = 1,
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
        return {
            vars = {
                card.ability.extra.chance,
                G.GAME.probabilities.normal * card.ability.extra.total_chance,
                card.ability.extra.a_chance,
                Kino.jump_scare_mult
            }
        }
    end,
    calculate = function(self, card, context)
        --  Cards have a 1/10 chance to jump scare. 
        -- Whenever you play a high card, increase it by 1. (Jump Scare == give X3, get destroyed after scoring.)
        -- Card Destruction through jump scares needs to be INJECTED
        if context.before and context.scoring_name == "High Card" then
            card.ability.extra.total_chance = card.ability.extra.total_chance + card.ability.extra.a_chance
        end

        if context.individual and context.cardarea == G.play then
            if pseudorandom('terror_train') < (G.GAME.probabilities.normal * card.ability.extra.total_chance) / card.ability.extra.chance then
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