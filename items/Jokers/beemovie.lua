if Cryptid and Talisman then
SMODS.Joker {
    key = "beemovie",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_created = 3
        }
    },
    rarity = "cry_exotic",
    atlas = "kino_exotic",
    pos = { x = 1, y = 0},
    soul_pos = { x = 1, y = 2, extra = { x = 1, y = 1 } },
    cost = 50,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Animation", "Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.j_kino_beemovie_honeygrate
        return {
            vars = {
                card.ability.extra.cards_created
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            for i = 1, card.ability.extra.cards_created do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.jokers then
                            local _card = SMODS.add_card({ key = "j_kino_beemovie_honeygrate" })
                            _card:set_edition("e_negative", true, nil, true)
                            return true
                        end
                    end,
                }))
            end
        end
    end
}
end