SMODS.Joker {
    key = "contagion",
    order = 213,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 2, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 39538,
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
    pools, k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.scoring_hand[1] ~= context.other_card then
                local _source_card = context.scoring_hand[1].ability

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

                for _key, _upgrade in pairs(upgrades) do
                    if context.other_card.ability[_key] and context.other_card.ability[_key] > _upgrade then
                        
                    else
                        context.other_card.ability[_key] = _upgrade
                    end

                    
                end

                return {
                    message = localize("k_contagion")
                }
            end
        end
    end
}