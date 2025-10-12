SMODS.Joker {
    key = "scarface_1",
    order = 266,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11474,
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
    k_genre = {"Crime"},
    enhancement_gate = 'm_kino_crime',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you sell a consumable, steal money equal to its sell value
        if context.selling_card and context.card.ability.set ~= 'Joker' then
            Kino:steal_money(context.card.cost)

            return {
                message = localize("k_crime_card"),
            }
        end
    end
}