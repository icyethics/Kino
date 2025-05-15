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
        kino_sci_fi_sprites = {
            level = {
                display_1 = nil,
                display_2 = nil,
                display_3 = nil,
                display_4 = nil
            }
        }
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
    upgrade = function(self, card)
        card.ability.times_upgraded = card.ability.times_upgraded + 1
        card.ability.bonus = card.ability.bonus + card.ability.a_chips

        if next(find_joker('j_kino_terminator_2')) then
            for index, _joker in ipairs(G.jokers.cards) do
                if type(_joker.ability.extra) == "table" and
                _joker.ability.extra.affects_sci_fi then
                    card.ability.x_mult = card.ability.x_mult + _joker.ability.extra.perma_x_mult
                end
            end
        else
            card.ability.mult = card.ability.mult + card.ability.a_mult
        end
                
                
        G.GAME.current_round.sci_fi_upgrades = G.GAME.current_round.sci_fi_upgrades + 1
        G.GAME.current_round.sci_fi_upgrades_last_round = G.GAME.current_round.sci_fi_upgrades_last_round + 1
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

-- local blind_indicator_sprite
-- SMODS.DrawStep {
--     key = "kino_blind_sprite",
--     order = 50,
--     func = function(card, layer)
--         if card and SMODS.has_enhancement(card, 'm_kino_sci_fi') then
--             if card.ability.kino_sci_fi_sprites.level.display_1 then
            
--             end
--         end
--         -- if G.GAME.current_round.boss_blind_indicator then
--         --     if G.jokers and G.jokers.cards and G.jokers.cards[1] then
--         --         if card == G.jokers.cards[1] then
--         --             local _xOffset = 0.5
--         --             local _yOffset = 2.25
--         --             local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
--         --             local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

--         --             blind_indicator_sprite = blind_indicator_sprite or Sprite(0, -10, card.T.w, card.T.h, G.ASSET_ATLAS["kino_ui"], {x = 5, y = 0})
--         --             blind_indicator_sprite.role.draw_major = card
--         --             blind_indicator_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + _yOffset,nil, 0.6)
--         --             -- blind_indicator_sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
--         --             -- blind_indicator_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, 0.1, nil, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL) + self.T.h*-0.2, nil, 0.6)
--         --             blind_indicator_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
--         --             -- blind_indicator_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, 0.1, nil, nil, self.T.h*-0.2)
--         --         end
--         --     else
--         --     end
--         -- end

--         -- if card and card.children.back_uibox then
--         --     card.children.back_uibox.states.visible = false
--         -- end
--     end,
--     conditions = {vortex = false, facing = 'front'}
-- }