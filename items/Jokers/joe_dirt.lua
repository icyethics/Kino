SMODS.Joker {
    key = "joe_dirt",
    order = 28,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 4
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 4},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10956,
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
    k_genre = {"Comedy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard then 
            local _has_triggered = false
            for _index, _pcard in ipairs(context.full_hand) do
                if not _pcard.debuff and not _pcard:is_suit("Spades") then
                    card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
                    _has_triggered = true
                end
            end
            
            if _has_triggered then
                return {
                    message = localize('k_upgrade_ex'),
                    card = card,
                    colour = G.C.CHIPS
                }
            end
        end

        if context.individual and context.cardarea == G.play and
        context.other_card:is_suit("Spades") then
            return {
                chips = card.ability.extra.stacked_chips,
                card = card
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
            card.ability.extra.stacked_chips = 0

            return {
                message = localize("k_reset")
            }
        end
    end
}