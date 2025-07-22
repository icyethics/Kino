SMODS.Joker {
    key = "her",
    order = 239,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 4, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 152601,
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
    pools, k_genre = {"Sci-fi", "Romance"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_sci_fi") or
                SMODS.has_enhancement(v, "m_kino_romance") then

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

            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _romance_cards = 0
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_kino_romance') and not context.scoring_hand[i].debuff then
                    _romance_cards = _romance_cards + 1
                end
            end

            if _romance_cards == 2 then
                for _, _pcard in ipairs(G.hand.cards) do
                    if SMODS.has_enhancement(_pcard, 'm_kino_sci_fi') then
                        _pcard.config.center:upgrade(_pcard)
                    end
                end
            end
        end
    end
}