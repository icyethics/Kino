SMODS.Joker {
    key = "easy_a",
    order = 253,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 50
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 0, y = 0},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 37735,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives +50 chips for each Ace held in hand
        if context.joker_main then
            local _count = 0
            for _, _card in ipairs(G.hand.cards) do
                if _card:get_id() == 14 then
                    _count = _count + 1
                end
            end

            return {
                chips = _count * card.ability.extra.chips
            }
        end
    end
}