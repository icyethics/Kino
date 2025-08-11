SMODS.Enhancement {
    key = "sci_fi",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 0},
    config = {
        a_mult = 1,
        a_chips = 5,
        bonus = 0,
        mult = 0,
        x_mult = 1,
        times_upgraded = 0,
        times_upgraded_ui = 0,
        sprite_state = "level"
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.a_mult or self.config.a_mult,
                card and card.ability.a_chips or self.config.a_chips,
                card and card.ability.bonus or self.config.bonus,
                card and card.ability.mult or self.config.mult,
                card and card.ability.x_mult or self.config.x_mult,
                card and card.ability.times_upgraded or self.config.times_upgraded
            }
        }
    end,
    upgrade = function(self, card, num)
        local _upgradenum = num or 1
        card.ability.times_upgraded = card.ability.times_upgraded + _upgradenum

        if card.ability.times_upgraded_ui < 99 then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function() 
                card.ability.times_upgraded_ui = math.min(card.ability.times_upgraded_ui + _upgradenum, 99)

                return true end)
        }))
        end
        card.ability.bonus = card.ability.bonus + (card.ability.a_chips * _upgradenum)

        if next(find_joker('j_kino_terminator_2')) then
            for index, _joker in ipairs(G.jokers.cards) do
                if type(_joker.ability.extra) == "table" and
                _joker.ability.extra.affects_sci_fi then
                    card.ability.x_mult = card.ability.x_mult + (_joker.ability.extra.perma_x_mult *  _upgradenum)
                end
            end
        else
            card.ability.mult = card.ability.mult + (card.ability.a_mult *  _upgradenum)
        end
                
                
        G.GAME.current_round.sci_fi_upgrades = G.GAME.current_round.sci_fi_upgrades + _upgradenum
        G.GAME.current_round.sci_fi_upgrades_last_round = G.GAME.current_round.sci_fi_upgrades_last_round + _upgradenum
        SMODS.calculate_context({upgrading_sci_fi_card = true})
    end,
    calculate = function(self, card, context, effect)
        if (context.main_scoring and context.cardarea == G.play and not context.repetition) or context.sci_fi_upgrade then

            if (context.sci_fi_upgrade_target ~= nil and context.sci_fi_upgrade_target ~= card) then
                return 
            end 

            
            local times_to_upgrade = 1
            local wall_e = false
            -- Sets values, as upgrade should happen after scoring
            if G.GAME.current_round.scrap_total and G.GAME.current_round.scrap_total > 0 and next(find_joker('j_kino_wall_e')) then
                times_to_upgrade = 1 + G.GAME.current_round.scrap_total
                wall_e = true
            end

            -- grab additional upgrades from jokers
            for _, _joker in ipairs(G.jokers.cards) do
                if type(_joker.ability.extra) == "table" and
                _joker.ability.extra.kino_sci_fi_upgrade_inc then
                    times_to_upgrade = times_to_upgrade + _joker.ability.extra.kino_sci_fi_upgrade_inc
                end
            end

            -- grab additional upgrades given in context
            if context.kino_sci_fi_upgrade_count then
                times_to_upgrade = times_to_upgrade + context.kino_sci_fi_upgrade_count
            end

            for i = 1, times_to_upgrade do 
                card.config.center:upgrade(card)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_upgrade_ex'), colour = G.C.CHIPS })
                
            end

            if wall_e then
                update_scrap(0, true)
            end
        end
    end
}


SMODS.DrawStep {
    key = "kino_sci_fi_counter",
    order = 2,
    func = function(self, layer)
        if self and SMODS.has_enhancement(self, 'm_kino_sci_fi') and G.shared_segdisp then
            if self.ability.sprite_state == "level" then
                if true == false and type(G.shared_segdisp[1][11].draw) == 'function' then
                    G.shared_segdisp[1][11]:draw(self, layer)
                    G.shared_segdisp[2][12]:draw(self, layer)
                else
                    G.shared_segdisp[1][11].role.draw_major = self
                    G.shared_segdisp[1][11]:draw_shader('dissolve', nil, nil, nil, self.children.center)

                    G.shared_segdisp[2][12].role.draw_major = self
                    G.shared_segdisp[2][12]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                end
                local _values = {0, 0}
                _values[2] = self.ability.times_upgraded_ui % 10
                _values[1] = (self.ability.times_upgraded_ui - _values[2]) / 10
                
                for i = 1, 2 do
                    if true == false and  type(G.shared_segdisp[2 + i][_values[i] + 1].draw) == 'function' then
                        G.shared_segdisp[2 + i][_values[i]  + 1]:draw(self, layer)
                    else
                        if G.shared_segdisp[2 + i][_values[i]  + 1] then
                            G.shared_segdisp[2 + i][_values[i]  + 1].role.draw_major = self
                            G.shared_segdisp[2 + i][_values[i]  + 1]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                        end
                    end
                end
            end

            -- Chips display
            if self.ability.sprite_state == "chips" then
                
            end

            -- Mult display
            if self.ability.sprite_state == "mult" then
                
            end

        end
    end,
    conditions = {vortex = false, facing = 'front'}
}