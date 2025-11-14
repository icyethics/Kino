SMODS.Joker {
    key = "cat_people",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            counters_applied = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 5, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 25508,
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
    k_genre = {"Thriller", "Romance"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        info_queue[#info_queue+1] = {key = 'counter_retrigger', set = 'Counter'}
        return {
            vars = {
                card.ability.extra.counters_applied
            }
        }
    end,
    enhancement_gate = "m_lucky",
    calculate = function(self, card, context)
        -- When a Lucky Card fails
        -- Put a retrigger counter on it
        if context.pseudorandom_result and not context.result and
        context.trigger_obj.ability.effect == "Lucky Card" then
            context.trigger_obj.kino_cat_people_trigger = (context.trigger_obj.kino_cat_people_trigger or 0) + 1
            if context.trigger_obj.kino_cat_people_trigger == 2 then
                return {
                    message = localize("k_kino_cat_people")
                }
            end
        end

        if context.after then
            for _index, _pcard in ipairs(G.playing_cards) do
                if _pcard.kino_cat_people_trigger and _pcard.kino_cat_people_trigger >= 2 then
                    _pcard:bb_counter_apply("counter_retrigger", card.ability.extra.counters_applied)
                end
                _pcard.kino_cat_people_trigger = nil
            end
        end
    end
}