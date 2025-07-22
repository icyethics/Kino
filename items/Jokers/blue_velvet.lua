SMODS.Joker {
    key = "blue_velvet",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            a_stacks_consumable = 1,
            a_stacks_destroy = 3,
            chips = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 4, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 793,
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
    pools, k_genre = {"Crime", "Thriller"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.a_stacks_consumable,
                card.ability.extra.a_stacks_destroy,
                card.ability.extra.chips,
                card.ability.extra.stacks * card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When
        if context.using_consumeable and not context.blueprint then
            card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_stacks_consumable
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.Mult })
        end

        if context.remove_playing_cards and not context.blueprint then
            for _, _pcard in ipairs(context.removed) do
                card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_stacks_destroy
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.Mult })
            end
        end

        if context.joker_main and card.ability.extra.stacks > 0 then
            local _chips = card.ability.extra.stacks * card.ability.extra.chips
            if not context.blueprint then
                card.ability.extra.stacks = card.ability.extra.stacks - 1
            end
            return {
                chips = _chips
            }
        end
    end
}