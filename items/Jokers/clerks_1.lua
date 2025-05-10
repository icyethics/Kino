SMODS.Joker {
    key = "clerks_1",
    order = 186,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            threshold = 37,
            mult = 18
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 5, y = 0},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2292,
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
    pools, k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.threshold,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.blueprint then

                card.ability.extra.stacks = card.ability.extra.stacks + math.max(context.other_card:get_id(), 0)
            end

            if card.ability.extra.stacks >= card.ability.extra.threshold then

                card.ability.extra.stacks = 0 

                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}