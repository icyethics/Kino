SMODS.Joker {
    key = "star_wars_viii",
    order = 328,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            stacks = 0,
            factor = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 4, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 181808,
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
    pools = {["kino_starwars"] = true}, 
    k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.factor,
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) * card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        -- |When a card is scored, give Mult equal to current stacks, then lose 1 stack.
        -- Stacks equal number of planets used and reset when you select a blind
        if context.setting_blind and not context.repetition and not context.blueprint then
            card.ability.extra.stacks = (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) * card.ability.extra.factor
        end

        if context.individual and context.cardarea == G.play then
            if card.ability.extra.stacks > 0 then
                local _mult = card.ability.extra.stacks
                card.ability.extra.stacks = card.ability.extra.stacks - 1
                return {
                    mult = _mult
                }
            else
                return {
                    message = localize("k_kino_starwars_viii")
                }
            end
        end
    end
}