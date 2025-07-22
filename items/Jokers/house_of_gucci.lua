SMODS.Joker {
    key = "house_of_gucci",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 20,
            mult = 8,
            x_mult = 1.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 3, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 644495,
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
    pools, k_genre = {"Drama", "Biopic", "Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Cards with an enhancement give +15 chips. +8 mult if they have a seal. X1.5 mult if they have an edition
        if context.individual and context.cardarea == G.play then
            local _return = {}
            local _returnbool = false

            if context.other_card.config.center ~= G.P_CENTERS.c_base then
                _return["chips"] = card.ability.extra.chips
                _returnbool = true
            end

            if context.other_card.seal ~= nil then
                _return["mult"] = card.ability.extra.mult
                _returnbool = true
            end

            if context.other_card.edition then
                _return["x_mult"] = card.ability.extra.x_mult
                _returnbool = true
            end

            if _returnbool then
                return _return
            end
        end
    end
}