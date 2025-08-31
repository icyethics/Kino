SMODS.Joker {
    key = "sleepy_hollow",
    order = 56,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 1, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2668,
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
    pools, k_genre = {"Fantasy", "Mystery"},
    enhancement_gate = "m_kino_demonic",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_horror
        info_queue[#info_queue+1] = G.P_CENTERS.m_kino_monster
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        -- Monster and Horror cards count as any suit when making a Flush

    end
}