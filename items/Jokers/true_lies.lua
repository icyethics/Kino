SMODS.Joker {
    key = "true_lies",
    order = 62,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 36955,
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
    k_genre = {"Thriller", "Action"},
    enhancement_gate = "m_wild",

    loc_vars = function(self, info_queue, card)
        local _king_count = 0
        if G.hand then
            for _, _card in ipairs(G.hand.cards) do
                if _card:get_id() == 13 then
                    _king_count = _king_count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.repetitions,
                _king_count * card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- Wild cards retrigger once for each king in hand
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if SMODS.has_enhancement(context.other_card, "m_wild") then
                local _king_count = 0
                for _, _card in ipairs(G.hand.cards) do
                    if _card:get_id() == 13 then
                        _king_count = _king_count + 1
                    end
                end

                return {
                    message = 'Again',
                    repetitions = _king_count * card.ability.extra.repetitions,
                    card = context.other_card
                }
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades.count or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard:get_id() == 13 and _pcard.config.center == G.P_CENTERS.m_wild then
                    _tally = _tally + 1
                end
            end

            if _tally >= 5 then
                unlock_card(self)
            end
        end
    end,
}