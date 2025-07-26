SMODS.Joker {
    key = "young_frankenstein",
    order = 234,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            codex = {},
            codex_solve = Kino.get_dummy_codex(),
            codex_type = 'rank',
            codex_length = 5,
            solved = false,
            mult = 20
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 5, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 3034,
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
    pools, k_genre = {"Comedy", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            },
            main_end = Kino.codex_ui(card.ability.extra.codex_solve)
        }
    end,
    calculate = function(self, card, context)

        -- When you solve the codex, upgrade every played card with +20 mult

        if context.joker_main then
            local result = false
            if not context.blueprint and not context.repetition then
                card.ability.extra.codex_solve, result = Kino.check_codex(card, card.ability.extra.codex, context.full_hand, card.ability.extra.codex_solve)
                if result == true then
                    card.ability.extra.solved = true
                    card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, card.ability.extra.codex_type, card.ability.extra.codex_length, 'young_frankie')
                end
            end

            if card.ability.extra.solved then
                for _, _pcard in ipairs(context.full_hand) do
                    _pcard.ability.perma_mult = _pcard.ability.perma_mult or 0
                    _pcard.ability.perma_mult = _pcard.ability.perma_mult + card.ability.extra.mult
                end
            end
        end
        
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, card.ability.extra.codex_type, card.ability.extra.codex_length, 'young_frankie')
   
    end,
}