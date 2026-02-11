SMODS.Joker {
    key = "truman_show",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            current_rating_non = 100,
            ratings_max_non = 500,
            ratings_min_non = 0,
            current_colour = G.C.GREY,
            past_ten_ratings = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

            -- Tracking Data
            last_played_hands = {"None", "None", "None"},
            last_consumables_used = {"None", "None", "None"},
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 1, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 37165,
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
    k_genre = {"Drama", "Sci-fi", "Comedy"},

    loc_vars = function(self, info_queue, card)
        -- local _colour = G.C.GREY
        -- if card.ability.extra.current_rating_non > card.ability.extra.past_ten_ratings[1] then
        --     print("GREEN")
        --     _colour = G.C.GREEN
        -- elseif card.ability.extra.current_rating_non < card.ability.extra.past_ten_ratings[1] then
        --     print("RED")
        --     _colour = G.C.RED
        -- end

        local main_end = {
            -- {n=G.UIT.T, config={text = '  +',colour = G.C.CHIPS, scale = 0.32}},
            {n=G.UIT.C, config={align = "cm", func = "truman_func", ref_table = card}, nodes ={

                    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR}, nodes ={
                        {n=G.UIT.O, config={object = DynaText({
                        string = {{prefix = "", ref_table = card.ability.extra.past_ten_ratings, ref_value = 3}}, colours = {G.C.JOKER_GREY}, bump = true,pop_in_rate = 5, silent = true, pop_delay = 0.5, scale = 0.2, min_cycle_time = 0})
                        }},
                    }},
                    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR}, nodes ={
                        {n=G.UIT.O, config={object = DynaText({
                        string = {{prefix = "", ref_table = card.ability.extra.past_ten_ratings, ref_value = 2}}, colours = {G.C.JOKER_GREY}, bump = true,pop_in_rate = 5, silent = true, pop_delay = 0.5, scale = 0.24, min_cycle_time = 0})
                        }},
                    }},
                    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR}, nodes ={
                        {n=G.UIT.O, config={object = DynaText({
                        string = {{prefix = "", ref_table = card.ability.extra.past_ten_ratings, ref_value = 1}}, colours = {G.C.JOKER_GREY}, bump = true,pop_in_rate = 5, silent = true, pop_delay = 0.5, scale = 0.27, min_cycle_time = 0})
                        }},
                    }},
                    
                    -- Current Rating
                    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR}, nodes ={
                        {n=G.UIT.O, config={object = DynaText({
                        string = {{prefix = "", ref_table = card.ability.extra, ref_value = 'current_rating_non'}},colours = {card.ability.extra.current_colour}, bump = true,pop_in_rate = 5, silent = true, pop_delay = 0.5, scale = 0.4, min_cycle_time = 0})
                        }},
                    }}
                    -- colour = card.ability.extra.current_colour

            }}
        }
        return {
            vars = {

            },
            main_end = main_end
        }
    end,
    calculate = function(self, card, context)
        -- Gain the current ratings as chips
        -- ratings go up when you do something flashy
        -- ratings go down when you do something boring

        if context.joker_main then
            local _chips = card.ability.extra.current_rating_non
            return {
                chips = _chips
            }
        end

        if context.after and context.cardarea == G.jokers and not context.repetition and not context.blueprint then
            local _cur_ratings = card.ability.extra.current_rating_non
            
            -- Adjust rating for hand played
            for _count, _played_hand in ipairs(card.ability.extra.last_played_hands) do
                if _played_hand == context.scoring_name then
                    card.ability.extra.current_rating_non = card.ability.extra.current_rating_non - 3
                end
            end

            -- Adjust rating if most played
            local _hand, _tally = nil, -1

            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played > _tally) then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end

            if context.scoring_name == _hand then
                card.ability.extra.current_rating_non = card.ability.extra.current_rating_non - 5
            else
                card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 2
            end

            for _count, _played_hand in ipairs(card.ability.extra.last_played_hands) do
                local _index = 1 + #card.ability.extra.last_played_hands - _count
                if _index == 1 then
                    card.ability.extra.last_played_hands[_index] = context.scoring_name
                else
                    card.ability.extra.last_played_hands[_index] = card.ability.extra.last_played_hands[_index - 1]
                end
            end

            -- Card qualities
            local _played_suits = {}
            local _played_ranks = {}
            local _played_seals = {}
            local _played_enhancements = {}
            local _played_editions = {}
            for _index, _pcard in ipairs(context.scoring_hand) do
                if not SMODS.has_no_suit(_pcard) and not SMODS.has_any_suit(_pcard) then
                    if not _played_suits[_pcard.base.suit] then
                        _played_suits[_pcard.base.suit] = true
                        card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 1
                    end
                end
                if not SMODS.has_no_rank(_pcard) then
                    if not _played_ranks[_pcard:get_id()] then
                        _played_ranks[_pcard:get_id()] = true
                        card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 0.5
                    end
                end
                if _pcard.seal then
                    if not _played_seals[_pcard.seal] then
                        _played_seals[_pcard.seal] = true
                        card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 1
                    end
                end
                if _pcard.config.center ~= G.P_CENTERS.c_base then
                    if not _played_enhancements[_pcard.config.center.key] then
                        _played_enhancements[_pcard.config.center.key] = true
                        card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 1
                    end
                end
                if _pcard.edition ~= nil then
                    card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 1
                    if not _played_editions[_pcard.edition.key] then
                        _played_editions[_pcard.edition.key] = true
                        card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 1
                    end
                end
            end

            return {
                message = tostring(card.ability.extra.current_rating_non - _cur_ratings)
            }
        end

        if context.discard and not context.repetition and not context.blueprint then
            local _cur_ratings = card.ability.extra.current_rating_non
            card.ability.extra.current_rating_non = card.ability.extra.current_rating_non - 1

            if context.other_card.seal and context.other_card.seal == "Purple" then
                card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 2
            end

            if context.other_card.edition then
                card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 1
            end

            return {
                message = tostring(card.ability.extra.current_rating_non - _cur_ratings)
            }
        end

        if context.using_consumeable and not context.repetition and not context.blueprint then
            local _cur_ratings = card.ability.extra.current_rating_non

            for _count, _used_consumable in ipairs(card.ability.extra.last_consumables_used) do
                if _used_consumable == context.consumeable.ability.key then
                    card.ability.extra.current_rating_non = card.ability.extra.current_rating_non - 1
                end
            end
            card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + 2

            for _count, _used_consumable in ipairs(card.ability.extra.last_consumables_used) do
                local _index = 1 + #card.ability.extra.last_consumables_used - _count
                if _index == 1 then
                    card.ability.extra.last_consumables_used[_index] = context.consumeable.ability.key
                else
                    card.ability.extra.last_consumables_used[_index] = card.ability.extra.last_consumables_used[_index - 1]
                end
            end

            return {
                message = tostring(card.ability.extra.current_rating_non - _cur_ratings)
            }
        end
        
    end,
    add_to_deck = function(self, card, from_debuff)
        local _timer = 1
        local event
            event = Event {
                blockable = false,
                blocking = false,
                pause_force = true,
                no_delete = true,
                trigger = "after",
                delay = _timer,
                timer = "UPTIME",
                func = function()
                    
                    if card:can_calculate() then
                        -- ambient_decay
                        local _ambient_decay = pseudorandom("DEBUG", -0.2, 0.01)
                        

                        for _count, _rating in ipairs(card.ability.extra.past_ten_ratings) do
                            local _index = #card.ability.extra.past_ten_ratings - _count
                            if _index == 1 then
                                card.ability.extra.past_ten_ratings[_index] = card.ability.extra.current_rating_non
                            else
                                card.ability.extra.past_ten_ratings[_index] = card.ability.extra.past_ten_ratings[_index - 1]
                            end
                            
                        end

                        card.ability.extra.current_rating_non = card.ability.extra.current_rating_non + _ambient_decay
                        card.ability.extra.current_colour = G.C.GREY
                        if card.ability.extra.current_rating_non > card.ability.extra.past_ten_ratings[1] then
                            card.ability.extra.current_colour = G.C.GREEN
                        elseif card.ability.extra.current_rating_non < card.ability.extra.past_ten_ratings[1] then
                            card.ability.extra.current_colour = G.C.RED
                        end

                        event.start_timer = false
                    else
                        return true
                    end
                end
            }
            

            G.E_MANAGER:add_event(event)
    end,
}

-- 

G.FUNCS.truman_func = function(e)
    local card = e.config.ref_table
    e.children[4].children[1].config.object.colours = {card.ability.extra.current_colour}
end

-- Rating Changers

-- Buying a new card - Big boost, based on money spend

-- Playing a hand:
-- If hand type was played recently previous hand: -----
-- If hand type is most played: -
-- Each different suit: +
-- Each different rank: +0.5
-- Each different enhancement or seal: +
-- played card has an edition: +
-- played card is first of that edition: +

-- Discarding a hand:
-- per card discarded: -
-- card with edition discarded: +
-- purple seal discarded: +

-- Ambient decay: between 0 and ----

-- pausing the game: -
-- leaving a run: -----

-- Using a consumable: ++
-- Using a consumable that was one of the 3 previously used consumables: -

-- Dragging a card around all over the place: ++
-- mouse motion: +0.5

-- local TV_Sprite
-- local UI_Sprite
-- local canvas = love.graphics.newCanvas(1920, 1080)
-- canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
-- SMODS.DrawStep {
--     key = "kino_truman_show",
--     order = 50,
--     func = function(card, layer)
--         if card and card.config.center == G.P_CENTERS.j_kino_truman_show then
--             TV_Sprite = TV_Sprite or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_ui"], {x = 8, y = 0})
--             TV_Sprite.role.draw_major = card
--             TV_Sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, 0.5,2)

--             love.graphics.push()
--             love.graphics.origin()
--             canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
--             love.graphics.setColor(1, 1, 1)
--             canvas:renderTo(love.graphics.print, card.ability.extra.current_rating_non, 175, 50, 0, 1.5)
--             love.graphics.pop()

--             UI_Sprite = UI_Sprite or UISprite(0, 0, G.CARD_W, G.CARD_H,
--             G.ASSET_ATLAS["kino_ui"], { x = 0, y = 0 })
--             UI_Sprite.role.draw_major = card
--             UI_Sprite:draw_shader(card.children.center, canvas)
--         end
--     end,
--     conditions = {vortex = false, facing = 'front'}
-- }