SMODS.Joker {
    key = "creature_from_the_black_lagoon",
    order = 13,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            perma_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 2 },
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10973,
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
    pools, k_genre = {"Horror", "Romance", "Fantasy"},
    is_water = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- If your played hand is only a Queen, destroy it and upgrade every card in your deck with +1 mult.

        -- Checks if only 1 card is played, and if it's a Queen.
        if context.destroying_card and not context.blueprint then 
            if context.full_hand and #context.full_hand == 1 and context.full_hand[1]:get_id() == 12 then
                -- Iterate through every owned card.
                for i, v in ipairs(G.playing_cards) do
                    v.ability.perma_mult = v.ability.perma_mult or 0
                    v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.perma_mult
                end
                return true
            end
        end
    end
}
