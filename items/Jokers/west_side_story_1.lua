SMODS.Joker {
    key = "west_side_story_1",
    order = 175,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 100,
            mult = 20
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1725,
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
    pools, k_genre = {"Crime", "Romance", "Musical"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- check if you have more scoring red or black suits and gain 100 chips or 20 mult depending on which one
        if context.joker_main then
            local _red = 0
            local _black = 0
            for i, _card in ipairs(context.scoring_hand) do
                if _card:is_suit("Hearts") or _card:is_suit("Diamonds") then
                    _red = _red + 1
                end
                if _card:is_suit("Spades") or _card:is_suit("Clubs") then
                    _black = _black + 1
                end
            end

            if _red < _black then
                return {
                    chips = card.ability.extra.chips,
                    message = localize("k_west_side_jets"),
                    colour = G.C.CHIPS
                }
            elseif _red > _black then
                return {
                    mult = card.ability.extra.mult,
                    message = localize("k_west_side_sharks"),
                    colour = G.C.MULT
                }
            elseif _red == _black then
                return {
                    message = localize("k_west_side_neither")
                }
                
            end
        end
    end
}