SMODS.Joker {
    key = "skyscraper",
    order = 4,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_mult = 0,
            stacked_mult_mod = 0.5,
            a_mult = 0.5,
            hand_type = "High Card"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 0 },
    cost = 3,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 447200,
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
    pools, k_genre = {"Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_mult_mod,
                card.ability.extra.stacked_mult,
                card.ability.extra.a_mult,
                card.ability.extra.hand_type
            }
        }
    end,
    calculate = function(self, card, context)
        -- gains +1 if you play a high card. Increases by +1 after you defeat a boss blind.

        if context.before and context.scoring_name == card.ability.extra.hand_type and not context.blueprint then
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.stacked_mult_mod
            return {
                focus = card,
                message = localize({type='variable', key='a_mult', vars = {card.ability.extra.stacked_mult}}),
                colour = G.C.MULT,
                card = card
            }

        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.stacked_mult_mod = card.ability.extra.stacked_mult_mod + card.ability.extra.a_mult
            card.ability.extra.stacked_mult = 0
            return {
                focus = card,
                message = localize({type='variable', key='k_upgrade_ex', vars = {card.ability.extra.stacked_mult_mod}}),
                colour = G.C.MULT,
                card = card
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}