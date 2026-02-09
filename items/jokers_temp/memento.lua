SMODS.Joker {
    key = "memento",
    order = 100,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 77,
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
    k_genre = {"Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards trigger twice
        -- When you make an action (discard, play, use/sell consumable/joker)
        -- flip all cards in hand.

        if (context.before or context.pre_discard) 
        and not context.blueprint then
            for j=1, #G.hand.cards do
                G.hand.cards[j]:flip()
            end
        end

        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            return {
                message = 'Again???',
                repetitions = card.ability.extra.repetitions,
                card = context.other_card
            }
        end
    end
}