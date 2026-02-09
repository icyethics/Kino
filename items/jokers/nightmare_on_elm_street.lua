SMODS.Joker {
    key = "nightmare_on_elm_street",
    order = 158,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 1.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 377,
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
    k_genre = {"Horror"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_horror") or
                SMODS.has_enhancement(v, "m_kino_monster") then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Monster cards held in hand give 1.5x mult
        if context.individual and context.cardarea == G.hand and 
        SMODS.has_enhancement(context.other_card, "m_kino_monster") then
            return {
                x_mult = card.ability.extra.x_mult,
                card = context.other_card
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if (_pcard.config.center == G.P_CENTERS.m_kino_horror or _pcard.config.center == G.P_CENTERS.m_kino_monster) then
                    _tally = _tally + 1
                end
            end

            if _tally >= 10 then
                unlock_card(self)
            end
        end
    end,
}