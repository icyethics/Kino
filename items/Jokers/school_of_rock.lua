SMODS.Joker {
    key = "school_of_rock",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1584,
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
    pools, k_genre = {"Musical", "Comedy"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Turn every scoring card of 5 or lower into a Stone card before scoring
        if context.before and not context.blueprint and not context.retrigger then
            for _index, _pcard in ipairs(context.scoring_hand) do
                if _pcard:get_id() <= 5 then
                    local _target_card = _pcard
                    G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0.4,
                                func = function()
                                    card:juice_up(0.3, 0.4)
                                    _target_card:juice_up(0.3, 0.4)
                                    _target_card:set_ability("m_stone")
                                    return true
                                end,
                            }))
                end
            end
            
            
        end
    end
}