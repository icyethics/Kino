SMODS.Joker {
    key = "star_wars_ii",
    order = 326,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            factor = 2
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 0},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1894,
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
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                local _source_card = context.removed[1].ability

                local upgrades = {
                    perma_bonus = _source_card.perma_bonus,
                    perma_mult = _source_card.perma_mult,
                    perma_x_chips = _source_card.perma_x_chips,
                    perma_x_mult = _source_card.perma_x_mult,
                    perma_h_chips = _source_card.perma_h_chips,
                    perma_h_x_chips = _source_card.perma_h_x_chips,
                    perma_h_mult = _source_card.perma_h_mult,
                    perma_h_x_mult = _source_card.perma_h_x_mult,
                    perma_p_dollars = _source_card.perma_p_dollars,
                    perma_h_dollars = _source_card.perma_h_dollars,
                }

                for _, _pcard in ipairs(G.playing_cards) do
                    if context.removed[1]:get_id() == _pcard:get_id() then
                        for _key, _upgrade in pairs(upgrades) do
                            _pcard.ability[_key] = _pcard.ability[_key] or 0
                            _pcard.ability[_key] = _pcard.ability[_key] + (_upgrade * card.ability.extra.factor)
                        end
                    end
                end
            end
            return {
                message = localize("k_kino_starwars_ii")
            }
        end
    end
}