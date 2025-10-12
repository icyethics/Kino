SMODS.Joker {
    key = "tmnt_1",
    order = 293,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetition = 1,
            suits = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 4, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1498,
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
    k_genre = {"Action", "Family", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetition
            }
        }
    end,
    calculate = function(self, card, context)
        -- retrigger the first card of each suit

        if context.cardarea == G.play and context.repetition then

            -- Check for suits already encountered
            local _is_viable = true
            for i = 1, #card.ability.extra.suits do
                if context.other_card.config.card.suit == card.ability.extra.suits[i] then
                    _is_viable = false
                    break
                end 
            end

            if _is_viable and 
            context.other_card.config.center ~= G.P_CENTERS.m_stone then
                
                card.ability.extra.suits[#card.ability.extra.suits + 1] = context.other_card.config.card.suit

                local _repetitions = card.ability.extra.repetition 

                return {
                    repetitions = _repetitions,
                    message = localize('k_kino_tmnt_1')
                }
            end
        end

        if context.after then
            card.ability.extra.suits = {}
        end
    end
}