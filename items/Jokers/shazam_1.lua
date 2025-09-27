SMODS.Joker {
    key = "shazam_1",
    order = 210,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 5, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 287947,
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
    pools, k_genre = {"Fantasy", "Superhero"},
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
        if context.bb_cast_spell then
            local _valid_targets = {}

            for _, _card in ipairs(G.hand.cards) do
                if not _card:is_face() then
                    _valid_targets[#_valid_targets + 1] = _card
                end
            end

            if #_valid_targets > 1 then
                local i_card = pseudorandom_element(_valid_targets, pseudoseed("shazam"))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    i_card:juice_up(0.8, 0.5)
                    card:juice_up(0.8, 0.5)
                    card_eval_status_text(i_card, 'extra', nil, nil, nil,
                    { message = localize('k_shazam'), colour = G.C.MULT })
                    i_card:flip()
                    delay(0.1)
                    SMODS.change_base(i_card, nil, 'Jack')
                    i_card:flip()
                    delay(0.23)
                return true end }))
            end
        end
    end
}