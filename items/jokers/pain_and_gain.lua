SMODS.Joker {
    key = "pain_and_gain",
    order = 224,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            x_mult = 2.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 1, y = 1},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 134374,
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
    k_genre = {"Action", "Crime"},
    enhancement_gate = "m_kino_action",
    kino_bullet_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Retrigger a random card once for each bullet

        -- OLD EFFECT
        -- if context.before then
        --     card.ability.extra.bullets_non = Kino:count_bullets()
        --     local _array = {}

        --     for i = 1, #context.scoring_hand do
        --         card.ability.extra.retriggers[i] = 0
        --         _array[i] = i
        --     end

        --     for i = 1, card.ability.extra.bullets_non do
        --         local _index = pseudorandom_element(_array, pseudoseed('pag'))
        --         card.ability.extra.retriggers[_index] = card.ability.extra.retriggers[_index] + 1
        --     end
        -- end

        -- if context.repetition and context.cardarea == G.play then
        --     for _, _pcard in ipairs(context.scoring_hand) do
        --         if context.other_card == _pcard then
        --             return {
        --                 repetitions = card.ability.extra.retriggers[_]
        --             }
        --         end
        --     end
        -- end

        -- if context.after then
        --     card.ability.extra.bullets_non = 0
        --     card.ability.extra.retriggers = {}
        -- end

        if context.individual and context.cardarea == G.play and 
        card.counter and G.P_COUNTERS.counter_kino_bullet_joker and
        card.ability.counter and card.ability.counter.counter_num and card.ability.counter.counter_num > 0 then
        
            
            card:bb_increment_counter(-1)

            return {
                x_mult = card.ability.extra.x_mult
            }
        end

    end
}