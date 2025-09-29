SMODS.Joker {
    key = "your_highness",
    order = 311,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 1,
            a_stacks = 1,
            threshold = 4,
            active = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 4, y = 3},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 38319,
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
    pools, k_genre = {"Comedy", "Fantasy", "Historical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.a_stacks,
                card.ability.extra.threshold - 1,
                card.ability.extra.threshold - card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        -- Every fourth consumable you obtain becomes negative
        if context.card_added then
            -- if context.card.set ~= "Voucher" or context.card.set ~=  "Joker" or context.card.set ~= "Booster" then
            if context.card.ability.consumeable then
                print("hello")
                if card.ability.extra.active then
                    context.card:set_edition({negative = true}, true)
                    card.ability.extra.active = false
                    card.ability.extra.stacks = card.ability.extra.stacks - card.ability.extra.threshold
                end
                
                card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_stacks

                if card.ability.extra.stacks >= card.ability.extra.threshold then
                    card.ability.extra.active = true

                    local eval = function(card)
                        return card.ability.extra.active
                    end

                    juice_card_until(card, eval, true)
                end
                
            end

        end
    end
}