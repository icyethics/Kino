-- -- codex code

-- -- Types of Codex
-- -- Suit Codex (only suits matter)
-- -- Rank Codex (only ranks matter)
-- -- Complex Codex (both ranks and suits matter)
-- -- Varied Codex (each entry can be rank or suit)
-- -- Supervaried Codex (each entry can be rank, suit or complex)

-- -- NEW:
-- -- Only two types of codex: Rank and Suit. Never complex

-- ---check if the given sequence of cards matches the codex
-- ---@param card Card
-- ---@param codex table
-- ---@param checking_cards table
-- ---@return table?
-- function Kino.check_codex(card, codex, checking_cards, solved_codex) 
--     local _solved_codex = solved_codex
--     local _result = true

--     for i = 1, #codex do
--         local _card = checking_cards[i]
--         local _suitmatch = false
--         local _rankmatch = false

--         if _solved_codex[i].suit ~= nil then
--             _suitmatch = true
--         elseif codex[i].suit ~= nil and _card and _card:is_suit(codex[i].suit) then
--             _solved_codex[i].suit = codex[i].suit
--             _suitmatch = true
--         elseif codex[i].suit == nil then
--             _suitmatch = true
--         else
--             _solved_codex[i].suit = nil
--         end

--         if _solved_codex[i].rank ~= nil then
--             _rankmatch = true
--         elseif codex[i].rank ~= nil and _solved_codex[i].rank == nil and _card and _card:get_id() == codex[i].rank then
--             _solved_codex[i].rank = codex[i].rank
--             _rankmatch = true
--         elseif codex[i].rank == nil then
--             _rankmatch = true
--         else
--             _solved_codex[i].rank = nil
--         end

--         if not _suitmatch or not _rankmatch then
--             _result = false
--         end
--     end

--     return _solved_codex, _result
-- end

-- ---check if the given sequence of cards matches the codex
-- ---@param card Card
-- ---@param codex table
-- ---@param checking_cards table
-- ---@return table?
-- function Kino.assess_played_hand(card, codex)
--     local _solved_codex = Kino.get_dummy_codex()
--     local _played_hand = G.GAME.last_played_hand
--     local _result = true

--     if _played_hand == nil then
--         return _solved_codex
--     end

--     for i = 1, #_played_hand do

--         if _played_hand[i] == nil then
--             break
--         end
--         local _card = _played_hand[i]
--         local _rankmatch = false

--         _solved_codex[i].rank = _card.rank
--         -- 0 is no match
--         _solved_codex[i].rank_correctness = 0

--         for j = 1, #codex do
--             if _card.rank == codex[j].rank then
--                 -- 0 if right rank but wrong spot
--                 _solved_codex[i].rank_correctness = 1

--                 -- 2 if right rank and right spot
--                 if i == j then
--                     _solved_codex[i].rank_correctness = 2
--                     break
--                 end
--             end
--         end

        

--     end

--     return _solved_codex
-- end

-- ---creates a codex sequence of rank and suits
-- ---@param loc_limits table
-- ---@param type string
-- ---@param length number
-- ---@param codexseed string
-- ---@return table?
-- function Kino.create_codex(loc_limits, type, length, codexseed)
--     if not G.playing_cards then return false end

--     type = string.lower(type)
--     if not length then
--         length = 5
--     end

--     local _selected_cards = {}
--     local _solved_codex = {}

--     for i = 1, length do 
--         local _card = pseudorandom_element(G.playing_cards, pseudoseed("codex_" .. codexseed))

--         _selected_cards[#_selected_cards + 1] = _card
--         _solved_codex[i] = {suit = nil, rank = nil}
--     end

--     local _ret_codex = {}
--     for _, _pcard in ipairs(_selected_cards) do
--         _ret_codex[#_ret_codex + 1] = {suit = nil, rank = nil}
--         if type == "suit" or type == "complex" then
--             _ret_codex[#_ret_codex].suit = _pcard.base.suit
--         end
--         if type == "rank" or type == "complex" then
--             _ret_codex[#_ret_codex].rank = _pcard.base.id
--         end
--     end

--     return _ret_codex, _solved_codex
-- end

-- function Kino.codex_ui(codex_solve, reveal_all)
--     local _key_nodes = {}


--     if not codex_solve then
--         print("no codex given")
--         codex_solve = Kino.get_dummy_codex()
--     end

--     for _, _unit in ipairs(codex_solve) do

--         local _base_colour = G.C.GREY
--         local _base_text = "??"

--         if reveal_all or _unit.rank ~= nil  then
--             _base_text = Kino.rank_to_string(_unit.rank)
--         end
--         if _unit.suit ~= nil then
--             _base_colour = G.C.SUITS[_unit.suit]
--         end
--         -- rank correctness
--         if _unit.rank_correctness == 0 then
--             _base_colour = G.C.GREY
--         elseif _unit.rank_correctness == 1 then
--             _base_colour = G.C.MONEY
--         elseif _unit.rank_correctness == 2 then
--             _base_colour = G.C.GREEN
--         end
    
        

--         _key_nodes[#_key_nodes + 1] = {
--             n = G.UIT.C,
--             config = {   
--                 minh = 0.5,
--                 minw = 0.5,                     
--                 maxh = 0.5,
--                 maxw = 0.5,
--                 r = 0.1,
--                 colour = _base_colour,
--                 align = 'cm'
--             },
--             nodes = {
--                 {
--                     n = G.UIT.T,
--                     config = {
--                         text = _base_text,
--                         colour = G.C.WHITE, 
--                         scale = 0.3, 
--                         shadow = false
--                     }
--                 }
--             }
--         }
--     end

--     return {
--         n = G.UIT.R,
--         config = {
--             align = 'cm',
--             colour = G.C.CLEAR,
--             padding = 0.1
--         },
--         nodes = _key_nodes
--     }
-- end


--         -- card.ability.extra.codex, card.ability.extra.codex_solve = Kino.create_codex(nil, card.ability.extra.codex_type, card.ability.extra.codex_length, 'oppie')