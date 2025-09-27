SMODS.Joker {
    key = "sorcerers_apprentice",
    order = 190,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 3, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 27022,
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
    pools, k_genre = {"Fantasy"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_fantasy") then
                    enhancement_gate = true
                    break
                end
            end

            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.kino_spellcaster then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever a fantasy card casts a spell
        if context.bb_cast_spell and context.repeatable then
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_harry_potter'), colour = G.C.PURPLE })
            return cast_spell(context.spell_key, context.strength - 1, false)
            -- return true
        end
    end
}