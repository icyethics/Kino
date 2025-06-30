SMODS.Joker {
    key = "pirates_of_the_caribbean_1",
    order = 242,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cost_mod = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 1, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 22,
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
    pools, k_genre = {"Fantasy", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cost_mod
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you destroy a card, lose $10 and create a copy with a random enhancement instead

        if context.remove_playing_cards then
            for i = 1, #context.removed do 
                for _index, _joker in ipairs(G.jokers.cards) do
                    if _joker == card then
                        if G.jokers.cards[_index - 1] and G.jokers.cards[_index - 1].set_cost then
                            G.jokers.cards[_index - 1].ability.extra_value = G.jokers.cards[_index - 1].ability.extra_value + card.ability.extra.cost_mod
                            G.jokers.cards[_index - 1]:set_cost()
                        end
                        if G.jokers.cards[_index + 1] and G.jokers.cards[_index + 1].set_cost then
                            G.jokers.cards[_index + 1].ability.extra_value = G.jokers.cards[_index + 1].ability.extra_value + card.ability.extra.cost_mod
                            G.jokers.cards[_index + 1]:set_cost()
                        end
                    end
                end
                SMODS.calculate_effect({
                        message = localize("k_kino_pirates_1"),
                        colour = G.C.MONEY
                    }, card)
            end
        end
    end
}