SMODS.Joker {
    key = "inception",
    order = 105,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            adapted_non = 0,
            a_adapted = 1,
            copied_cards = {},
            current_target = nil
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 5},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 27205,
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
    k_genre = {"Sci-fi", "Crime"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_COUNTERS.counter_drowsy
        return {
            vars = {

            },
        }
    end,
    calculate = function(self, card, context)
        -- When you select a Blind, put a Drowsy counter on the joker to the right
        -- Copies the ability of Drowsy jokers
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local _my_pos = nil
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker == card then
                    _my_pos = _index
                end
            end

            if G.jokers.cards[_my_pos + 1] then
                G.jokers.cards[_my_pos + 1]:bb_counter_apply('counter_drowsy', 1)
            end
        end

        local effects = {}
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card then 
                other_joker = G.jokers.cards[i] 
                if Blockbuster.Counters.is_counter(other_joker, "counter_drowsy") then
                    effects[#effects + 1] = SMODS.blueprint_effect(card, other_joker, context)
                end
            end
        end

        if #effects > 0 then
            return SMODS.merge_effects(effects)
        end
    end,
    update = function(self, card, front)

	end,
}