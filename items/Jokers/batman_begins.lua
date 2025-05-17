SMODS.Joker {
    key = "batman_begins",
    order = 102,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money = 2,
            total_non = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 272,
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
    j_is_batman = true,
    pools, k_genre = {"Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
                card.ability.extra.total_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- At the end of the round, gain $1 for each open joker slot (Batman jokers are excluded)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.total_non = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.money
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.j_is_batman then card.ability.extra.total_non = card.ability.extra.total_non + 1 * card.ability.extra.money end
            end
        end
    end,
    calc_dollar_bonus = function(self, card)

        return card.ability.extra.total_non
    end
}