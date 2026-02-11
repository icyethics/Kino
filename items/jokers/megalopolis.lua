SMODS.Joker {
    key = "megalopolis",
    order = 23,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            suit = "Clubs",
            b_chips = 10,
            chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 592831,
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
    k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.suit,
                card.ability.extra.b_chips,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Clubs give +10 chips for each other scoring Club.
        if context.before and not context.blueprint then
            local num_suit = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.card.suit == card.ability.extra.suit and not v.debuff then
                    num_suit = num_suit + 1
                end
            end
            card.ability.extra.chips = card.ability.extra.b_chips * num_suit
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.suit) then
                return {
                    chips = card.ability.extra.chips,
                    card = context.other_card
                }
            end
        end
    end
}