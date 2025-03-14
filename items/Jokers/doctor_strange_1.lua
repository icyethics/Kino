SMODS.Joker {
    key = "doctor_strange_1",
    order = 211,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            goal = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 5},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 284052,
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
    pools, k_genre = {"Fantasy", "Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.goal
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_spell_cast then
            card.ability.extra.stacks = card.ability.extra.stacks + 1

            if card.ability.extra.stacks == card.ability.extra.goal then
                card.ability.extra.stacks = 0
                return {
                    spell_key = "EyeOfAgamoto"
                }
            end
        end
    end
}