-- Kino.create_snackbag_tab = function()
--     return UIBox {
--         definition = {
--             n = G.UIT.ROOT,
--             config = {
--                 minh = G.consumeables.T.x + 2.25,
--                 maxh = G.consumeables.T.x + 2.25,
--                 minw = G.consumeables.T.y + G.consumeables.T.h + 1,
--                 maxw = G.consumeables.T.y + G.consumeables.T.h + 1,
--                 colour = G.C.BLACK
--             },
--             nodes = {
--                 {
--                     n = G.UIT.C,
--                     config = {
--                         minh = G.consumeables.T.x + 2.25,
--                         maxh = G.consumeables.T.x + 2.25,
--                         minw = G.consumeables.T.y + G.consumeables.T.h + 1,
--                         maxw = G.consumeables.T.y + G.consumeables.T.h + 1,
--                         align = 'cm' 
--                     },
--                     nodes = {
--                         {
--                             n = G.UIT.R,
--                             config = {
--                                 align = "cm",
--                                 padding = 0.2,
--                                 colour = G.C.WHITE
--                             },
--                             nodes = {
--                                 {
--                                     n = G.UIT.O,
--                                     config = {
--                                         object = Kino.snackbag
--                                     }
--                                 },
--                             }
--                         },
--                     }
--                 },
--             }
--         }
--     }
-- end
local cae = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)

    if self == G.consumeables and card.ability.set == "confection" and 
    G.GAME.used_vouchers.v_kino_snackbag and (not card.config.center.is_snackbag) then
        if #Kino.snackbag.cards == 0 then
            local _snackbag = SMODS.create_card({type = "confection", area = G.consumeables, key = "c_kino_snackbag", no_edition = true})
            G.consumeables:emplace(_snackbag)
        end
        Kino.snackbag:emplace(card, location, stay_flipped)
        return 
    end

    cae(self, card, location, stay_flipped)
end