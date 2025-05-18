SMODS.Joker {
    key = "la_la_land",
    order = 254,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 313369,
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
    pools, k_genre = {"Musical", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- if your hand contains only 1 card, upgrade each card in hand with chips equal to its rank
        if context.after and context.full_hand and #context.full_hand == 1 and
        G.GAME.current_round.hands_played == to_big(0) then
            local _value = context.full_hand[1].base.id

            for _, _pcard in ipairs(G.hand.cards) do
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus or 0
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus + _value 
            end
            
            return {
                card = context.full_hand[1],
                message = localize("k_lalaland")
            }
        end
    end
}