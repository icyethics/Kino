SMODS.Joker {
    key = "frankenstein",
    order = 99,
    config = {
        extra = {
            chips = 0,
            mult = 0,
            xmult = 1,
            dollars = 0,
            xchips = 1,
            factor = 1,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 3035,
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
    pools, k_genre = {"Horror", "Fantasy"},

    loc_vars = function(self, info_queue, card)


        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult,
                card.ability.extra.dollars,
                card.ability.extra.xchips,
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card is destroyed, gain bonuses based on its suit

        if context.remove_playing_cards and not context.blueprint then
            for _, _pcard in ipairs(context.removed) do
                local _suits = SMODS.Suits
                for _suitname, _suitdata in pairs(_suits) do
                    if _pcard:is_suit(_suitname) then
                        if _suitname == 'Diamonds' then
                            card.ability.extra.dollars = card.ability.extra.dollars + (card.ability.extra.factor / 2)
                        elseif _suitname == 'Hearts' then
                            card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.factor * 0.1)
                        elseif _suitname == 'Spades' then
                            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.factor * 3)
                        elseif _suitname == 'Clubs' then
                            card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.factor)
                        else
                            card.ability.extra.xchips = card.ability.extra.xchips + (card.ability.extra.factor * 0.1)
                        end
                    end
                end
            end



        end

        if context.joker_main then
            return {
                dollars = card.ability.extra.dollars,
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                x_mult = card.ability.extra.xmult,
                x_chips = card.ability.extra.xchips
            }
        end
    end
}