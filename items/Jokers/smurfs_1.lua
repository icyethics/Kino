SMODS.Joker {
    key = "smurfs_1",
    order = 209,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_chips = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 41513,
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
    pools, k_genre = {"Fantasy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_chips,
                (G.GAME.current_round.spells_cast or 0) * card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and 
        (context.other_card:get_id() == 2 or context.other_card:get_id() == 3) then
            return {
                
                chips = G.GAME.current_round.spells_cast * card.ability.extra.a_chips
            }
        end
    end
}