SMODS.Joker {
    key = "children_of_the_corn",
    order = 188,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 80
        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 1},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10823,
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

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then

            local _validtargets = {}

            for _, _pcard in ipairs(G.hand.cards) do
                if _pcard:is_face() then
                    _validtargets[#_validtargets + 1] = _pcard
                end
            end

            if #_validtargets > 0 then
                local _target = pseudorandom_element(_validtargets, pseudoseed("kino_childofcorn"))
                _target.marked_by_children_of_the_corn = true
                return {
                    chips = card.ability.extra.chips
                }
            end
        end

        if context.destroy_card and context.destroy_card.marked_by_children_of_the_corn then
            return {
                remove = true
            } 
        end
    end
}