SMODS.Joker {
    key = "social_network",
    order = 79,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_chips = 5,
            face_tally = 0,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 37799,
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
    k_genre = {"Drama", "Biopic"},

    loc_vars = function(self, info_queue, card)

        local face_tally = 0
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:is_face() then face_tally = face_tally+1 end
            end
        end
        return {
            vars = {
                card.ability.extra.a_chips,
                face_tally * card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- +5 chips for each face card in your deck

        if context.joker_main then
            card.ability.extra.face_tally = 0
            for k, v in pairs(G.playing_cards) do
                if v:is_face() then card.ability.extra.face_tally = card.ability.extra.face_tally+1 end
            end
            return {
                chips = card.ability.extra.face_tally * card.ability.extra.a_chips
            }
        end
    end
}