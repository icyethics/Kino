SMODS.Joker {
    key = "resident_evil",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 4, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1576,
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
    pools, k_genre = {"Horror", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If you discard a single card
        -- destroy every card with the same rank held in hand
        if context.discard and context.cardarea == G.jokers
        and #context.full_hand == 1 and 
        not context.blueprint and not context.retrigger_joker then
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:get_id() == context.full_hand[1]:get_id() 
                and _pcard ~= context.full_hand[1] then
                    -- check if already in hand
                    _pcard.marked_by_resident_evil = true
                end
            end
        end

        if context.remove_playing_cards then
            for _, _pcard in ipairs(context.removed) do
                if _pcard.marked_by_resident_evil then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_longlegs_ex'), colour = G.C.RED })
                    SMODS.debuff_card(card, true, "longlegs")
                end
            end
        end
    end
}