SMODS.Joker {
    key = "nightcrawler",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1,
            duration = 3,
            counters_non = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 0, y = 5},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 242582,
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
    pools, k_genre = {"Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.duration,
                1 + (#card.ability.extra.counters_non * card.ability.extra.x_mult)
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever you destroy a face card, this gains X1 mult for 3 blinds
        if context.remove_playing_cards then
            local _triggers = 0
            for i = 1, #context.removed do
                if context.removed[i]:is_face() then
                    _triggers = _triggers + 1
                    card.ability.extra.counters_non[#card.ability.extra.counters_non + 1] = card.ability.extra.duration
                end
            end

            if _triggers > 0 then
                return {
                    message = localize('k_upgrade_ex'), 
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then

            return {
                x_mult = 1 + (#card.ability.extra.counters_non * card.ability.extra.x_mult)
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.retrigger_joker and not context.blueprint then
            local _newtable = {}
            for _, _value in ipairs(card.ability.extra.counters_non) do
                if _value - 1 > 0 then
                    _newtable[#_newtable + 1] = _value -1
                end
            end
            card.ability.extra.counters_non = _newtable
        end
    end
}