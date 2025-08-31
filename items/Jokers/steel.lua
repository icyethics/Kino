SMODS.Joker {
    key = "steel",
    order = 180,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 5, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8854,
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
    pools, k_genre = {"Superhero"},
    enhancement_gate = 'm_steel',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gains +3 chips for each steel chip in hand

        if context.after and not context.blueprint then
            for i = 1, #G.hand.cards do
                if SMODS.has_enhancement(G.hand.cards[i], "m_steel") and not G.hand.cards[i].debuff then
                    card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
                end
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
    end
}