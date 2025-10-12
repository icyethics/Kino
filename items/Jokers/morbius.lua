SMODS.Joker {
    key = "morbius",
    order = 146,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.1,
            reset = 1

        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    kino_joker = {
        id = 526896,
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
    k_genre = {"Superhero"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult,
                card.ability.extra.reset
            }
        }
    end,
    calculate = function(self, card, context)
        -- Debuff all enhanced cards in your hand. Gains X0.1 mult for each card debuffed until the end of round.
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local _count = 0
            
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].config.center ~= G.P_CENTERS.c_base and not G.hand.cards[i].debuff and not G.hand.cards[i].vampired then
                    _count = _count + 1
                    G.hand.cards[i]:set_debuff(true)
                end
            end

            card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + (card.ability.extra.a_xmult * _count)
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
            }
        end

        if context.end_of_round and not context.repetition and not context.blueprint then
            card.ability.extra.stacked_x_mult = card.ability.extra.reset
        end
    end
}