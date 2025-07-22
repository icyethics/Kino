SMODS.Joker {
    key = "star_wars_iv",
    order = 335,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            stacks = 0,
            threshold = 77,
            factor = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_9",
    pos = { x = 4, y = 1},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11,
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
    pools = {["kino_starwars"] = true}, 
    k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.threshold,
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever you've played cards with a total value of 100, upgrade a random hand
        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.stacks = card.ability.extra.stacks + context.other_card.base.nominal
        end

        if context.after then
            while card.ability.extra.stacks >= (card.ability.extra.threshold / card.ability.extra.factor) do
                local handtype = get_random_hand()
                -- level_up_hand
                SMODS.smart_level_up_hand(context.blueprint_card or card, handtype, nil, 1)
                card.ability.extra.stacks = card.ability.extra.stacks - (card.ability.extra.threshold / card.ability.extra.factor)
                card:juice_up()
            end

            
        end
    end
}