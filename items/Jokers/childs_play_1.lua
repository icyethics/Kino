SMODS.Joker {
    key = "childs_play_1",
    order = 171,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_monster_exemptions = 0,
            a_stacks = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 4},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10585,
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
        local _string = "Inactive"
        if card.ability.extra.stacked_monster_exemptions > 0 then
            _string = "Active"
        end

        return {
            vars = {
                _string
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a hand containing a 2, activate
        -- When active, you may discard monster cards

        if context.joker_main then
            local _hastwo = false
            for i, _card in ipairs(context.scoring_hand) do
                if _card:get_id() == 2 then
                    _hastwo = true
                    break
                end
            end

            if _hastwo then
                card.ability.extra.stacked_monster_exemptions = card.ability.extra.stacked_monster_exemptions + card.ability.extra.a_stacks
            end
        end

        if context.pre_discard and context.cardarea == G.jokers and not context.blueprint and not context.repetition then
            for i, _card in ipairs(context.full_hand) do
                if SMODS.has_enhancement(_card, "m_kino_monster") then
                    card.ability.extra.stacked_monster_exemptions = 0
                end
            end
        end
    end
}