SMODS.Joker {
    key = "dirty_harry",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 20
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 4, y = 3},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 984,
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
    k_genre = {"Action"},
    enhancement_gate = "m_kino_action",
    kino_bullet_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
         -- When Loaded: Consume all Bullets and give +20 mult per bullet

        if context.joker_main and card.counter and card.counter == "counter_kino_bullet" and
        card.ability.counter and card.ability.counter.counter_num and card.ability.counter.counter_num > 0 then
            local _mult = card.ability.counter.counter_num * card.ability.extra.mult

            card:bb_increment_counter(-card.ability.counter.counter_num)

            return {
                mult = _mult
            }
        end
    end
}