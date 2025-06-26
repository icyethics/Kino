SMODS.Joker {
    key = "children_of_the_corn",
    order = 188,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 5,
            will_trigger = false,

        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10823,
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
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips,
                card.ability.extra.will_trigger
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.will_trigger = true
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    card.ability.extra.will_trigger = false
                end
            end
            
            return {
                chips = card.ability.extra.stacked_chips
            }
        end

        if context.destroy_card and card.ability.extra.will_trigger and context.cardarea == G.hand then

            if context.destroy_card:is_face() then
                card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
                return {remove = true}
            end
        end
    end
}