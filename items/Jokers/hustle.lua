SMODS.Joker {
    key = "hustle",
    order = 215,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            value_non = 5,
            value = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 705861,
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
    pools, k_genre = {"Sports"},

    loc_vars = function(self, info_queue, card)
        local _reps = 0
        local _curmoney = G.GAME.dollars + (G.GAME.dollar_buffer or 0)
        local _curstep = card.ability.extra.value_non
        while to_big(_curmoney) > to_big(_curstep) do
            _curmoney = _curmoney - _curstep
            _reps = _reps + 1
            _curstep = _curstep + (card.ability.extra.value_non / card.ability.extra.value)
            
        end
        return {
            vars = {
                card.ability.extra.value_non,
                card.ability.extra.value_non / card.ability.extra.value,
                _reps
            }
        }
    end,
    calculate = function(self, card, context)
        -- Your first card retriggers once for every $10 you have
        if context.cardarea == G.play and context.repetition 
        and (context.other_card == context.scoring_hand[1]) and not context.repetition_only
        then
            -- local _reps = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / (card.ability.extra.value_non / card.ability.extra.value))
            local _reps = 0
            local _curmoney = G.GAME.dollars + (G.GAME.dollar_buffer or 0)
            local _curstep = card.ability.extra.value_non
            while to_big(_curmoney) > to_big(_curstep) do
                _curmoney = _curmoney - _curstep
                _reps = _reps + 1
                _curstep = _curstep + (card.ability.extra.value_non / card.ability.extra.value)
                
            end
    
            return {
                message = localize("k_hustle"),
                repetitions = to_number(_reps),
                card = card
            }
        end
    end
}