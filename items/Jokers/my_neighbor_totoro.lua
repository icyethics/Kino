SMODS.Joker {
    key = "my_neighbor_totoro",
    order = 275,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 300,
            stacks = 0,
            threshold = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 4, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8392,
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
    k_genre = {"Animation", "Fantasy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.threshold - card.ability.extra.stacks,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        -- gives +300 chips every 3rd hand

        if context.joker_main then
            if not context.blueprint then
                card.ability.extra.stacks = card.ability.extra.stacks + 1
            end
            
            if card.ability.extra.stacks == card.ability.extra.threshold then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end

        if context.after then
            if card.ability.extra.stacks == card.ability.extra.threshold then
                card.ability.extra.stacks = 0
            end
        end
    end
}