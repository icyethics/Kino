SMODS.Joker {
    key = "dark_crystal",
    order = 181,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            charges_non = 0,
            a_charges = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11639,
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
    kino_spellcaster = true,
    pools, k_genre = {"Fantasy"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {
                card.ability.extra.charges_non,
                card.ability.extra.a_charges
            }
        }
    end,
    calculate = function(self, card, context)
        -- When your played hand doesn't win, gain a charge
        -- cast a spell if charged

        if context.after and not context.blueprint then
            if G.GAME.blind.chips > G.GAME.chips then
                card.ability.extra.charges_non = card.ability.extra.charges_non + card.ability.extra.a_charges
                return {
                    message = localize('k_charged'),
                    card = card,
                    colour = G.C.PURPLE
                }
            end
        end

        if context.joker_main and card.ability.extra.charges_non > 0 then
            if not context.blueprint or context.repetition then
                card.ability.extra.charges_non = card.ability.extra.charges_non - 1
            end

            local _result = cast_random_base_spell(2)

            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_spell_cast'), colour = G.C.PURPLE })
            return _result
        end
    end
}