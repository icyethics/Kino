if Cryptid and Talisman then
    -- Add 3 genres you currently already have present to a selected joker
-- SMODS.Consumable {
--     key = "rename",
--     set = "Code",
--     order = 100,
--     pos = {x = 0, y = 0},
--     atlas = "kino_cryptid_consumables",
--     config = {
--         extra = {
--             genres = 3
--         }
--     },
--     dependencies = {
-- 		items = {
-- 			"set_cry_code",
-- 		},
-- 	},
--     cost = 4,
--     loc_vars = function(self, info_queue, card)
--         return {
--             vars = {
--                 card.ability.extra.genres
--             }
--         }
--     end,
-- 	can_use = function(self, card)
-- 		return #G.jokers.highlighted == 1
-- 	end,
--     use = function(self, card, area, copier)
--         local _listofpresentgenres = {}

--         for _, _genre in ipairs(kino_genres) do
--             for j, joker in ipairs(G.jokers.cards) do
--                 if is_genre(joker, _genre, true) then
--                     _listofpresentgenres[#_listofpresentgenres + 1] = _genre
--                     break
--                 end
--             end
--         end
--         local _chosengenres = {}
--         for i = 1, card.ability.extra.genres do
--             _chosengenres[i] = pseudorandom_element(_listofpresentgenres, pseudoseed("kino_code_rename"))

--             for _, _genre in ipairs(_listofpresentgenres) do
--                 if _chosengenres[i] == _genre then
--                     table.remove(_listofpresentgenres, _)
--                 end
--             end

--             if #_listofpresentgenres == 0 then break end
--         end

--         if not G.jokers.highlighted[1].ability.kino_additional_genres then
--             G.jokers.highlighted[1].ability.kino_additional_genres = {}
--         end
--         print("-----------")
--         for i = 1, #_chosengenres do
--             print(G.jokers.highlighted[1].ability.kino_additional_genres)
--             G.jokers.highlighted[1].ability.kino_additional_genres[#G.jokers.highlighted[1].ability.kino_additional_genres + 1] = _chosengenres[i]
--         end

--     end
-- }
end