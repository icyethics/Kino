SMODS.Joker {
    key = "sound_of_music",
    order = 41,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            flavour_texts = {
                "Do, a deer a female deer",
                "Re, a drop of golden sun",
                "Mi, a name I call myself",
                "Fa, a long way to run",
                "So, a needle pulling thread",
                "La, a note to follow So",
                "Ti, a drink with jam and bread"
            },
            ranks_non = {
                14,
                2,
                3,
                4,
                5,
                6,
                7,
            },
            current_step_non = 1,
            stacked_mult = 0,
            stacked_temp_mult = 0,
            a_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 15121,
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
    pools, k_genre = {"Musical", "Romance", "Historical"},

    loc_vars = function(self, info_queue, card)

        local _rank = card.ability.extra.ranks_non[card.ability.extra.current_step_non]

        if _rank == 14 then
            _rank = "Ace"
        else 
            _rank = tostring(_rank)
        end

        return {
            vars = {
                card.ability.extra.flavour_texts[card.ability.extra.current_step_non],
                _rank,
                card.ability.extra.stacked_mult,
                card.ability.extra.stacked_temp_mult,
                card.ability.extra.stacked_mult + card.ability.extra.stacked_temp_mult,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                local _true = false
                for i, _card in ipairs(context.scoring_hand) do
                    if _card:get_id() == card.ability.extra.ranks_non[card.ability.extra.current_step_non] then
                        -- card.ability.extra.stacked_temp_mult = card.ability.extra.stacked_temp_mult + card.ability.extra.a_mult

                        _true = true
                    end
                end

                if _true then
                    card.ability.extra.stacked_temp_mult = card.ability.extra.stacked_temp_mult + card.ability.extra.a_mult
                    
                    if not context.repetition then
                        card.ability.extra.current_step_non = card.ability.extra.current_step_non + 1
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_upgrade_ex'), colour = G.C.MULT })
                    end
                end

                if card.ability.extra.current_step_non >= 7 and not context.repetition then
                    card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.stacked_temp_mult
                    card.ability.extra.stacked_temp_mult = 0
                    card.ability.extra.current_step_non = 0
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_upgrade_ex'), colour = G.C.MULT })
                end

                if not _true then
                    card.ability.extra.stacked_temp_mult = 0
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_reset'), colour = G.C.MULT })
                end

            end

            local _totalmult = card.ability.extra.stacked_mult + card.ability.extra.stacked_temp_mult
            
            return {
                mult = _totalmult
            }
        end
    end
}