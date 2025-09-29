SMODS.Joker {
    key = "harry_potter_1",
    order = 185,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            max_stacks = 14,
            cast_spell = false
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 671,
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
    pools, k_genre = {"Fantasy", "Family"},
    kino_spellcaster = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {
                card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if card.ability.extra.stacks < card.ability.extra.max_stacks then
                card.ability.extra.stacks = card.ability.extra.stacks + 1
            end
        end

        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            card.ability.extra.cast_spell = true
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_harry_potter'), colour = G.C.PURPLE })
            return Blockbuster.cast_spell("spell_Wild_Wild", card.ability.extra.stacks)
        end

        if context.after and G.GAME.current_round.hands_left == 0
        and card.ability.extra.cast_spell
        and not context.repetition and not context.blueprint then
            card.ability.extra.cast_spell = false
            card.ability.extra.stacks = 0
        end
    end
}