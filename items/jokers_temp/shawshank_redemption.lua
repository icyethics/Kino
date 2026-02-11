SMODS.Joker {
    key = "shawshank_redemption",
    order = 283,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 1, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 141,
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
    k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- when you discard a card, upgrade every card in hand with +4 chips
        if context.discard and context.cardarea == G.jokers then
            for _, _pcard in ipairs(G.hand.cards) do
                local _notdiscarding = true
                for __, _discard in ipairs(context.full_hand) do
                    if _pcard == _discard then _notdiscarding = false end
                end

                if _notdiscarding then
                    _pcard.ability.perma_bonus = _pcard.ability.perma_bonus or 0
                    _pcard.ability.perma_bonus = _pcard.ability.perma_bonus + card.ability.extra.chips
                end
            end
        end
    end
}