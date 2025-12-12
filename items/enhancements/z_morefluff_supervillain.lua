if next(SMODS.find_mod("MoreFluff")) then
SMODS.Enhancement {
    key = "supervillain",
    atlas = "kino_enhancements",
    pos = { x = 5, y = 5},
    config = {
        current_scheme = nil
    },
    loc_vars = function(self, info_queue, card)
        local key, vars
        if card.ability.current_scheme then
            key = self.key .. "_" .. card.ability.current_scheme
        else
            key = self.key
        end
        return { key = key, vars = vars }
    end,
    calculate = function(self, card, context, effect)
        -- Gives X0.5 mult for each hand used
        if context.main_scoring and context.cardarea == G.hand then

            if Kino.supervillain_foil_scheme(card, context, card.ability.current_scheme) then
                Kino.supervillain_level_all_hands(card)
                
                local _schemes = {
                    "toddler", 
                    "sidekick", 
                    "moon", 
                    -- "dinosaurs", 
                    "cakes"
                }

                card.ability.current_scheme = pseudorandom_element(_schemes, pseudoseed("kino_mf_villain"))

                return {
                    message = localize("k_kino_supervillain_foiled"),
                    colour = G.C.BLUE
                }
            end

            if Kino.supervillain_enact_scheme(card, context, card.ability.current_scheme) then
                return {
                    message = localize("k_kino_supervillain_enacted"),
                    colour = G.C.GREEN
                }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if card.area and card.area.config.collection then return end

        local _schemes = {
            "toddler", 
            "sidekick", 
            "moon", 
            -- "dinosaurs", 
            "cakes"
        }
        card.ability.current_scheme = pseudorandom_element(_schemes, pseudoseed("kino_mf_villain"))
    end,
}

function Kino.supervillain_level_all_hands(card)
    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
        { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true
        end
    }))
    update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            return true
        end
    }))
    update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true
        end
    }))
    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
    delay(1.3)
    for poker_hand_key, _ in pairs(G.GAME.hands) do
        SMODS.smart_level_up_hand(card, poker_hand_key, true)
    end
    update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
        { mult = 0, chips = 0, handname = '', level = '' })
end

function Kino.supervillain_enact_scheme(card, context, scheme)
    -- if context then print("context exist") end
    -- if context.poker_hands then print(context.poker_hands) end

   return Kino.table_of_schemes[scheme].enact(card, context)

end

function Kino.supervillain_foil_scheme(card, context, scheme)
    return Kino.table_of_schemes[scheme].foil(card, context)
end
-- Schemes
-- Stealing candy from a baby: lose $1 when you play a 2
    -- foiled by: playing a straight with a 2 in it
-- Kidnapping the sidekick: Destroy the joker with the lowest sell value when you play a high card
    -- foiled by: Seen you play a hand containing two pair while also holding a pair
-- Blowing up the moon: Put 2 debuff counters on scoring clubs
    -- Foiled by: Playing a flush
-- Turn everyone into dinosaurs: 
    -- Foiled by: Use your final discard on this card
-- Steal 40 cakes!: Whenever you play a hand, steals food
    -- Foiled by: playing a hand with values adding up to 40

Kino.table_of_schemes = {
    toddler = {
        localize = 'kino_mf_supervillain_scheme_toddler',
        enact = function(card, context)

            local _count = 0
            for _, _pcard in ipairs(G.play) do
                if _pcard:get_id() == 2 then
                    _count = _count + 1
                end
            end

            if _count > 0 then
                ease_dollars(-_count)
                return true
            end
            return false
        end,
        foil = function(card, context)

            if next(context.poker_hands['Straight']) then
                for _, _pcard in ipairs(G.play) do
                    if _pcard:get_id() <= 5 then
                        return true
                    end
                end
            end
            return false
        end
    }, 
    sidekick = {
        localize = 'kino_mf_supervillain_scheme_sidekick',
        enact = function(card, context)

            if context.scoring_name == "High Card" then
                local _cheapest = nil
                local _cheapest_price = nil
                local _valid_targets = {}
                for _, _joker in ipairs(G.jokers.cards) do
                    if not _cheapest_price then
                        _cheapest = _joker
                        _cheapest_price = _joker.sell_cost
                    elseif _cheapest_price and _cheapest_price >= _joker.sell_cost then
                        if _cheapest_price == _joker.sell_cost then
                            _valid_targets[#_valid_targets + 1] = _joker
                        elseif _cheapest_price > _joker.sell_cost then
                            _valid_targets = {}
                            _valid_targets[1] = _joker
                            _cheapest_price = _joker.sell_cost
                        end
                    end
                end

                -- select random joker
                if #_valid_targets > 0 then
                    local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_mf_villain_sidekick"))

                    if _target and _target:can_calculate(_target) then
                        SMODS.destroy_cards({_target})
                        return true
                    end
                end
            end
            return false
        end,
        foil = function(card, context)

            if next(context.poker_hands['Two Pair']) then
                -- check if pair is held in hand
                local _ranks = {}
                for _, _card in ipairs(G.hand.cards) do
                    local _rank1 = _card:get_id()

                    if not _ranks[_rank1] then
                        _ranks[_rank1] = 0
                    end
                    _ranks[_rank1] = _ranks[_rank1] + 1
                end

                for _rank, _count in pairs(_ranks) do
                    if _count >= 2 then
                        return true
                    end
                end
            end
            return false
        end
    }, 
    moon = {
        localize = 'kino_mf_supervillain_scheme_moon',
        enact = function(card, context)

            local _triggered = false
            for _, _pcard in ipairs(context.scoring_hand) do
                if _pcard:is_suit("Clubs") then
                    _pcard:bb_counter_apply("counter_stun", 2)
                    _triggered = true
                end
            end

            if _triggered then return true end
            return false
        end,
        foil = function(card, context)

            if next(poker_hands['Flush']) then
                return true
            end
            return false
        end
    },  
    dinosaurs = {
        localize = 'kino_mf_supervillain_scheme_dinosaurs',
        enact = function(card, context)

            return false
        end,
        foil = function(card, context)

            return false
        end
    },  
    cakes = {
        localize = 'kino_mf_supervillain_scheme_cakes',
        enact = function(card, context)

            G.GAME.kino_food_stolen = G.GAME.kino_food_stolen or 0
            G.GAME.kino_food_stolen = G.GAME.kino_food_stolen + 1
            return true
        end,
        foil = function(card, context)
            local _count = 0
            for _, _pcard in ipairs(context.scoring_hand) do
                _count = _count + _pcard.base.nominal
            end

            if _count == 40 then
                return true
            end

            return false
        end
    }, 
}

local supervillainSprite
SMODS.DrawStep {
    key = "kino_enhancement_supervillain_step",
    order = 51,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS.m_kino_supervillain then
            local _xOffset = 0
            local _yOffset = 0
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            supervillainSprite = supervillainSprite or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_morefluff_enhancements"], {x = 5, y = 1})
            supervillainSprite.role.draw_major = card
            -- supervillainSprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
            supervillainSprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
            supervillainSprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}



-- None consumable
-- None
SMODS.Consumable {
    key = "none",
    set = "confection",
    order = 18,
    pos = {x = 5, y = 3},
    atlas = "kino_confections",
    no_collection = true,
    config = {
        choco_bonus = 0,
        extra = {
            active = false,
            times_used = 0,
        }
    },
    in_pool = function(self, args)
        -- Check for the right frequency
        if G.GAME.kino_food_stolen and G.GAME.kino_food_stolen > 0 then
            return true
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {
            
            vars = {
            }
        } 
    end,
    pull_button = true,
    active = false,
    can_use = function(self, card)
        -- Checks if it can be activated
        if card.active == true or (card.area and card.area.config and card.area.config.type == 'shop') then
		    return false
        end

        -- Checks if it can be added to the inventory
        if card.area == G.pack_cards then
            if (#G.consumeables.cards < G.consumeables.config.card_limit or 
            (G.GAME.used_vouchers.v_kino_snackbag and #Kino.snackbag.cards < Kino.snackbag.config.card_limit)) then
                return true
            else
                return false
            end
                
        end

        return true
	end,
    keep_on_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if card.area ~= G.pack_cards and card.area ~= nil then
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            card.active = true

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true, 0.05)
        end
    end,
    calculate = function(self, card, context)

        if context.after and card.active then
            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}


end