SMODS.Joker {
    key = "krazy_house",
    order = 116,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1,
            xrange = 0.05,
            xrange_int = 1,
            a_xrange = 2,
            is_first = true

        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 1},
    cost = 1,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 607338,
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
    k_genre = {"Horror", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.xrange,
                card.ability.extra.xrange_int,
                1 - card.ability.extra.xrange * card.ability.extra.xrange_int,
                1 + card.ability.extra.xrange * card.ability.extra.xrange_int,
                card.ability.extra.xrange * card.ability.extra.a_xrange,
                card.ability.extra.a_xrange,
                card.ability.extra.is_first
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if ((context.scoring_name == "Full House" or
            context.scoring_name == "Flush House") and not context.blueprint) 
            or card.ability.extra.is_first == true then
                card.ability.extra.is_first = false
                card.ability.extra.xrange_int = card.ability.extra.xrange_int + card.ability.extra.a_xrange

                local _min = -1 * card.ability.extra.xrange_int
                local _max = card.ability.extra.xrange_int
                local _rand = pseudorandom("krazy", _min, _max)

                card.ability.extra.x_mult = 1 + (_rand * card.ability.extra.xrange)
            end

            return {
                x_mult = card.ability.extra.x_mult
            }
        end

        

    end
}
