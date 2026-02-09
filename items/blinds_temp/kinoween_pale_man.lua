-- SMODS.Atlas {
--     key = "kinoween_pale_man",
--     atlas_table = "ANIMATION_ATLAS",
--     path = "kinoween_pale_man_blind.png",
--     px = 54,
--     py = 54,
--     frames = 21
-- }

SMODS.Atlas {
    key = "kinoween_pale_man",
    atlas_table = "ANIMATION_ATLAS",
    path = "kinoween_pale_man_blind_2.png",
    px = 34,
    py = 34,
    frames = 21
}

SMODS.Blind{
    key = "pale_man",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('F0cdcd'),
    atlas = 'kinoween_pale_man', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    debuff = {

    },
    in_pool = function(self)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end,
    loc_vars = function(self)
        local key
        if G.GAME.kinoween_fruit_eaten then
            key = self.key .. "_awoken"
        else
            key = self.key
        end
        return { key = key}
    end,
    collection_loc_vars = function(self)
        local key
        if G.GAME.kinoween_fruit_eaten then
            key = self.key .. "_awoken"
        else
            key = self.key
        end
        return { key = key}

    end,
    set_blind = function(self)
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)
        local _targets = {}
        for _index, _joker in ipairs(G.jokers.cards) do
            if _joker:get_total_multiplier(_joker) > 1 then
                _targets[#_targets + 1] = _joker
            end
        end

        if #_targets > 0 then
            local _target = pseudorandom_element(_targets, pseudoseed("kinoween_pale_man"))
            if _target and _target:can_calculate(_target) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_kino_blind_pale_man'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = G.play,
                        align = 'tm',
                        offset = {x = 0, y = -1},
                        silent = true
                    })
                    self:wiggle()
                return true end }))
                
                SMODS.destroy_cards({_target})
                return true
            end
        end
    end,
    calculate = function(self, blind, context)

    end
}


-- None consumable
-- None
SMODS.Consumable {
    key = "fruit",
    set = "confection",
    order = 19,
    pos = {x = 4, y = 3},
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
        if G.GAME.modifiers.kinoween and G.GAME.round_resets.blind_choices.Boss == "bl_kino_pale_man" then
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
            G.GAME.kinoween_fruit_eaten = true
            card.active = true

            local eval = function(card) return card.active end
            juice_card_until(card, eval, true, 0.05)
        end
    end,
    calculate = function(self, card, context)

        if context.after and card.active then
            for _index, _joker in ipairs(G.jokers.cards) do
                Blockbuster.manipulate_value(_joker, "kinoween_fruit", 0.5, nil, true)
            end

            Kino.confection_trigger(card)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            Kino.powerboost_confection(card)
        end
    end
}


