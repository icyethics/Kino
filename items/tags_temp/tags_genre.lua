-- -- Horror
-- SMODS.Tag {
--     key = 'horror_genre',
--     atlas = 'kino_tags',
--     pos = {
--         x = 0,
--         y = 1
--     },
--     min_ante = 1,
--     config = {
--         type = 'immediate'
--     },
--     loc_vars = function(self, info_queue)
--     end,
--     in_pool = function(self, args)
--         if G.jokers then
--             for _index, _joker in ipairs(G.jokers.cards) do
--                 if is_genre(_joker, "Horror") then
--                     return true
--                 end
--             end
--         end
--     end,
--     apply = function(self, tag, context)
--         -- turn 2 random unenhanced cards in your deck into Horror or Demonic cards for each horror joker you have
--         if context.type == 'immediate' then
--             tag:yep('+', G.C.GREEN, function()
--                 local _count = 0

--                 for _index, _joker in ipairs(G.jokers.cards) do
--                     if is_genre(_joker, "Horror") then
--                         _count = _count + 1
--                     end
--                 end

--                 local _viable_targets = {}
--                 for _index, _pcard in ipairs(G.playing_cards) do
--                     if _pcard.config.center ~= G.P_CENTERS.c_base then
--                         _viable_targets[#_viable_targets + 1] = _pcard
--                     end
--                 end

--                 for i = 1, _count do
--                     local _target = pseudorandom_element(_viable_targets)

--                     if _target then
--                         if pseudorandom("kino_horror_tag") < 0.5 then
--                             _target:set_ability("m_kino_horror")
--                         else
--                             _target:set_ability("m_kino_demonic")
--                         end
--                     end
--                 end

--                 return true
--             end)
--             tag.triggered = true
--         end   
--     end
-- }

-- -- Sci-fi
-- SMODS.Tag {
--     key = 'scifi_genre',
--     atlas = 'kino_tags',
--     pos = {
--         x = 1,
--         y = 1
--     },
--     min_ante = 1,
--     config = {
--         type = 'immediate'
--     },
--     loc_vars = function(self, info_queue)
--     end,
--     in_pool = function(self, args)
--         if G.jokers then
--             for _index, _joker in ipairs(G.jokers.cards) do
--                 if is_genre(_joker, "Sci-fi") then
--                     return true
--                 end
--             end
--         end
--     end,
--     apply = function(self, tag, context)
--         -- upgrade 2 random hands for each Sci-fi joker
--         if context.type == 'immediate' then
--             tag:yep('+', G.C.GREEN, function()
--                 local _count = 0

--                 for _index, _joker in ipairs(G.jokers.cards) do
--                     if is_genre(_joker, "Sci-fi") then
--                         _count = _count + 2
--                     end
--                 end

--                 for i = 1, _count do
--                     local _target = get_random_hand()

--                     if _target then
--                         level_up_hand(nil, _target, nil, 1)
--                     end
--                 end

--                 return true
--             end)
--             tag.triggered = true
--         end   
--     end
-- }

-- -- Romance
-- SMODS.Tag {
--     key = 'romance_genre',
--     atlas = 'kino_tags',
--     pos = {
--         x = 2,
--         y = 1
--     },
--     min_ante = 1,
--     config = {
--         type = 'immediate',
--         genre = "Romance"
--     },
--     loc_vars = function(self, info_queue)
--     end,
--     in_pool = function(self, args)
--         if G.jokers then
--             for _index, _joker in ipairs(G.jokers.cards) do
--                 if is_genre(_joker, self.config.genre) then
--                     return true
--                 end
--             end
--         end
--     end,
--     apply = function(self, tag, context)
--         -- earn $2 per set of king and queens and $2 per duo of jacks
--         if context.type == 'immediate' then
--             local _kingcount = 0
--             local _queencount = 0
--             local _jackcount = 0

--             for _index, _pcard in ipairs(G.playing_cards) do
--                 if _pcard:get_id() == 11 then
--                     _jackcount = _jackcount + 1
--                 elseif _pcard:get_id() == 12 then
--                     _queencount = _queencount + 1
--                 elseif _pcard:get_id() == 13 then
--                     _kingcount = _kingcount + 1
--                 end
--             end

--             local _payout = math.floor(_jackcount / 2) + math.min(_kingcount, _queencount)

--             tag:yep('+', G.C.GREEN, function()
--                 return true
--             end)

--             ease_dollars(_payout)
--             tag.triggered = true

--             return true
--         end   
--     end
-- }

-- -- Mystery
-- -- SMODS.Tag {
-- --     key = 'mystery_genre',
-- --     atlas = 'kino_tags',
-- --     pos = {
-- --         x = 3,
-- --         y = 1
-- --     },
-- --     min_ante = 1,
-- --     config = {
-- --         type = 'immediate',
-- --         genre = "Mystery"
-- --     },
-- --     loc_vars = function(self, info_queue)
-- --     end,
-- --     in_pool = function(self, args)
-- --         if G.jokers then
-- --             for _index, _joker in ipairs(G.jokers.cards) do
-- --                 if is_genre(_joker, self.config.genre) then
-- --                     return true
-- --                 end
-- --             end
-- --         end
-- --     end,
-- --     apply = function(self, tag, context)
-- --         -- earn $2 per set of king and queens and $2 per duo of jacks
-- --         if context.type == 'immediate' then
-- --             local _kingcount = 0
-- --             local _queencount = 0
-- --             local _jackcount = 0

-- --             for _index, _pcard in ipairs(G.playing_cards) do
-- --                 if _pcard:get_id() == 11 then
-- --                     _jackcount = _jackcount + 1
-- --                 elseif _pcard:get_id() == 12 then
-- --                     _queencount = _queencount + 1
-- --                 elseif _pcard:get_id() == 13 then
-- --                     _kingcount = _kingcount + 1
-- --                 end
-- --             end

-- --             local _payout = math.floor(_jackcount / 2) + math.min(_kingcount, _queencount)

-- --             tag:yep('+', G.C.GREEN, function()
-- --                 return true
-- --             end)

-- --             ease_dollars(_payout)
-- --             tag.triggered = true

-- --             return true
-- --         end   
-- --     end
-- -- }
-- -- Fantasy
-- SMODS.Tag {
--     key = 'romance_genre',
--     atlas = 'kino_tags',
--     pos = {
--         x = 2,
--         y = 1
--     },
--     min_ante = 1,
--     config = {
--         type = 'immediate',
--         genre = "Romance"
--     },
--     loc_vars = function(self, info_queue)
--     end,
--     in_pool = function(self, args)
--         if G.jokers then
--             for _index, _joker in ipairs(G.jokers.cards) do
--                 if is_genre(_joker, self.config.genre) then
--                     return true
--                 end
--             end
--         end
--     end,
--     apply = function(self, tag, context)
--         -- earn $2 per set of king and queens and $2 per duo of jacks
--         if context.type == 'immediate' then
--             local _kingcount = 0
--             local _queencount = 0
--             local _jackcount = 0

--             for _index, _pcard in ipairs(G.playing_cards) do
--                 if _pcard:get_id() == 11 then
--                     _jackcount = _jackcount + 1
--                 elseif _pcard:get_id() == 12 then
--                     _queencount = _queencount + 1
--                 elseif _pcard:get_id() == 13 then
--                     _kingcount = _kingcount + 1
--                 end
--             end

--             local _payout = math.floor(_jackcount / 2) + math.min(_kingcount, _queencount)

--             tag:yep('+', G.C.GREEN, function()
--                 return true
--             end)

--             ease_dollars(_payout)
--             tag.triggered = true

--             return true
--         end   
--     end
-- }
-- -- Crime

-- -- Action

-- -- Superhero

-- -- Sports

-- -- Family

-- -- Adventure

-- -- Thriller
