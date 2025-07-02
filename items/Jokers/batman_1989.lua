SMODS.Joker {
    key = "batman_1989",
    order = 53,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            a_mult = 1,
            total_non = 0,
            stacked_mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 268,
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
    pools = {["kino_batman"] = true}, 
    k_genre = {"Superhero", "Action"},

    loc_vars = function(self, info_queue, card)
        
        if G.jokers then
            card.ability.extra.total_non = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.a_mult
            for i = 1, #G.jokers.cards do
                if kino_quality_check(G.jokers.cards[i], "is_batman") then 
                    card.ability.extra.total_non = card.ability.extra.total_non + (1 * card.ability.extra.a_mult)
                end
            end
        end

        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.total_non,
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- At the end of the round, gain +3 for each open joker slot.\
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.total_non = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.a_mult
            for i = 1, #G.jokers.cards do
                if kino_quality_check(G.jokers.cards[i], "is_batman") then 
                    card.ability.extra.total_non = card.ability.extra.total_non + (1 * card.ability.extra.a_mult)
                end
            end

            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.total_non
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}