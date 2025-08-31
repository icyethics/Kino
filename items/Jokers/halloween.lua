SMODS.Joker {
    key = "halloween",
    order = 159,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 10
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 948,
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
    pools, k_genre = {"Horror"},
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
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_horror
        return {
            vars = {
                card.ability.extra.chips,
                (G.GAME.current_round.horror_transform * card.ability.extra.chips) or 0
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives 20 chips for every time a Horror card has awoken.
        if context.joker_main then
            return {
                chips = G.GAME.current_round.horror_transform * card.ability.extra.chips
            }
        end
    end
}