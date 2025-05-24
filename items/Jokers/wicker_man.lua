SMODS.Joker {
    key = "wicker_man",
    order = 110,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9708,
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
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- when your first discard is only 1 card,
        -- destroy it and gain mult equal to its chips       
        -- resets after you defeat a boss blind

        if context.discard and G.GAME.current_round.discards_used <= 0
        and context.full_hand and #context.full_hand == 1
        and not context.hook and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + context.other_card.base.nominal + context.other_card.ability.perma_bonus
            return {
                message = localize('k_upgrade_ex'),
                remove = true,
                card = card
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.mult = 0
        end
        
    end
}