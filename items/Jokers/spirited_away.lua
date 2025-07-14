SMODS.Joker {
    key = "spirited_away",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            bonus_chips = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 129,
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
    pools, k_genre = {"Animation", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- when you select a blind, upgrade every card in your deck
        -- with +1 Chips
        if context.setting_blind then
            for _index, _pcard in ipairs(G.playing_cards) do
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus or 0
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus + card.ability.extra.bonus_chips
            end
        end
    end
}