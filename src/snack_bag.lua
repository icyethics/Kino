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
        if #Kino.snackbag.cards == 0 and Kino.snackbag_exists == false then
            local _snackbag = SMODS.create_card({type = "confection", area = G.consumeables, key = "c_kino_snackbag", no_edition = true})
            Kino.snackbag_exists = true
            G.consumeables:emplace(_snackbag)
        end
        Kino.snackbag:emplace(card, location, stay_flipped)
        card:set_card_area(Kino.snackbag)
        
        self:set_ranks()
        self:align_cards()
        return true
    end
    cae(self, card, location, stay_flipped)
end

local o_can_sell_card = Card.can_sell_card
function Card:can_sell_card(context)
    
    if self.area and
    self.area == Kino.snackbag and
    not self.ability.eternal then
        return true
    end
    return o_can_sell_card(self, context)
end

local o_sellcard = Card.sell_card
function Card:sell_card()
    local area = self.area
    o_sellcard(self)
end

local o_cfbs = G.FUNCS.check_for_buy_space
function G.FUNCS.check_for_buy_space(card)
    if card.ability.set == "confection" then
        -- (card.ability.consumeable and #G.consumeables.cards < G.consumeables.config.card_limit + (card.edition and card.edition.card_limit or 0))
        if G.GAME.used_vouchers.v_kino_snackbag and (not card.config.center.is_snackbag) and
        #Kino.snackbag.cards >= Kino.snackbag.config.card_limit then
            alert_no_space(card, card.ability.consumeable and G.consumeables or G.jokers)
            return false
        else
            return true
        end
    end
    return o_cfbs(card)
  
end

function debugcardareaprint(area)
    if area == Kino.snackbag then print('snack') end
    if area == G.kino_snackbag then print('snackbag in G') end
    if area == G.jokers then print('jokers') end
    if area == G.consumeables then print('consum') end
    if not area then print('nil') end
end