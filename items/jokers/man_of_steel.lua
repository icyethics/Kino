SMODS.Joker {
    key = "man_of_steel",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.5,
            mult = 10,
            triggered = false
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 49521,
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
    k_genre = {"Sci-fi", "Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- The first King held in hand gives x1.5 mult
        if context.individual and context.cardarea == G.hand and context.other_card:get_id() == 13
        and not context.end_of_round then
            local is_first_king = false
            for i = 1, #G.hand.cards do
                if G.hand.cards[i]:get_id() == 13 then
                    is_first_king = G.hand.cards[i] == context.other_card
                    break
                end
            end
            if is_first_king then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}