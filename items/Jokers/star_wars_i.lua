SMODS.Joker {
    key = "star_wars_i",
    order = 337,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            chips = 10,
            num_cards = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 0, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1893,
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
    pools = {["kino_starwars"] = true}, 
    k_genre = {"Sci-fi", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.num_cards,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- whenever you use a planet, upgrade 3 random cards in your deck with +10 chips
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            for i = 1, card.ability.extra.num_cards do
                local _pcard = pseudorandom_element(G.playing_cards, pseudoseed("star_wars_i"))
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus or 0
                _pcard.ability.perma_bonus = _pcard.ability.perma_bonus + card.ability.extra.chips
            end
            return {
                message = localize("k_kino_star_wars_i")
            }
        end
    end
}