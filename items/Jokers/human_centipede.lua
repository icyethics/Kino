if Cryptid and Talisman then

SMODS.Joker {
    key = "human_centipede",
    order = 337,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_emult = 0.1,
        }
    },
    rarity = "cry_epic",
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 2},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 37169,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                1 + card.ability.extra.a_emult,
                card.ability.extra.a_emult
            }
        }
    end,
    calculate = function(self, card, context)
        -- if context.before then
        --     card.ability.extra.times_triggered_non = 0
        -- end

        if context.individual and context.cardarea == G.play then
            if context.scoring_name == 'Straight' or (context.poker_hands and next(context.poker_hands['Straight'])) then
                local _mypos = nil
                for _, _pcard in ipairs(G.play.cards) do
                    if _pcard == context.other_card then
                        _mypos = _
                        break
                    end
                end

                return {
                    e_mult = 1 + (_mypos * card.ability.extra.a_emult)
                }
            end
        end

        if context.after then
            card.ability.extra.times_triggered_non = 0
        end
    end
}

end