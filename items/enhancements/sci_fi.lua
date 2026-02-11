SMODS.Enhancement {
    key = "sci_fi",
    name = "Sci-Fi Card",
    atlas = "kino_enhancements",
    pos = { x = 0, y = 0},
    config = {
        extra = {
            a_mult = 1,
            a_chips = 5,
            times_upgraded = 0,
            times_upgraded_ui = 0,
            sprite_state = "level"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.ability.extra.a_mult or self.config.a_mult,
                card and card.ability.extra.a_chips or self.config.a_chips,
                card and card.ability.perma_bonus or nil,
                card and card.ability.perma_mult or nil,
                card and card.ability.perma_x_mult or nil,
                card and card.ability.extra.times_upgraded or self.config.times_upgraded,
                bonus_chips_sci_fi = card.ability.extra.bonus or 10,
                bonus_mult = card.ability.extra.perma_mult or nil,
                bonus_xmult = card.ability.extra.perma_x_mult or nil
            },
            -- main_end = {
            --     localize{type = 'other', key = 'card_extra_chips', nodes = desc_nodes, vars = {SMODS.signed(specific_vars.bonus_chips_sci_fi)}}
            -- },
        }
    end,
    upgrade = function(self, card, num)
        local _upgradenum = num or 1
        card.ability.extra.times_upgraded = card.ability.extra.times_upgraded + _upgradenum
        inc_career_stat("kino_sci_fi_upgrades", _upgradenum)
        check_for_unlock({type = 'kino_sci_fi_upgrades', current_level = card.ability.extra.times_upgraded})
        if card.ability.extra.times_upgraded_ui < 99 then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function() 
                card.ability.extra.times_upgraded_ui = math.min(card.ability.extra.times_upgraded_ui + _upgradenum, 99)

                return true end)
        }))
        end
        card.ability.extra.bonus = (card.ability.extra.bonus or 0) + (card.ability.extra.a_chips * _upgradenum)
        if next(find_joker('j_kino_terminator_2')) then
            for index, _joker in ipairs(G.jokers.cards) do
                if type(_joker.ability.extra) == "table" and
                _joker.ability.extra.affects_sci_fi then
                    card.ability.extra.perma_x_mult = (card.ability.extra.perma_x_mult or 1) + (_joker.ability.extra.perma_x_mult *  _upgradenum)
                end
            end
        else
            card.ability.extra.perma_mult = (card.ability.extra.perma_mult or 0) + (card.ability.extra.a_mult *  _upgradenum)
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

            if card.ability.extra.times_upgraded >= 1 then
                local _return = {}

                _return.chips = card.ability.extra.bonus or 0
                _return.mult = card.ability.extra.perma_mult or 0
                if card.ability.extra.perma_x_mult then
                    _return.x_mult = card.ability.extra.perma_x_mult
                end

                return _return
            end
        end
    end,

    -- UI
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        local always_show = self.config and self.config.always_show or {}
        if specific_vars and specific_vars.nominal_chips and not self.replace_base_card then
            localize { type = 'other', key = 'card_chips', nodes = desc_nodes, vars = { specific_vars.nominal_chips } }
        end
        SMODS.Enhancement.super.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if specific_vars and specific_vars.bonus_chips then
            local remaining_bonus_chips = specific_vars.bonus_chips - (self.config.bonus or 0)
            if remaining_bonus_chips ~= 0 then
                localize { type = 'other', key = 'card_extra_chips', nodes = desc_nodes, vars = { SMODS.signed(remaining_bonus_chips) } }
            end
        end
        if card then
            local cfg = card.ability
            Kino.sci_fi_bonuses(cfg, specific_vars, desc_nodes)
        end
        SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
        
    end,
}

function Kino.sci_fi_bonuses(cfg, specific_vars, desc_nodes)
    if cfg and cfg.extra then
        if cfg.extra.bonus and cfg.extra.bonus > 0 then
            localize{type = 'other', key = 'kino_scifi_card_extra_chips', nodes = desc_nodes, vars = {SMODS.signed(cfg.extra.bonus)}}
        end
        if cfg.extra.perma_mult and cfg.extra.perma_mult > 0 then
            localize{type = 'other', key = 'kino_scifi_card_extra_mult', nodes = desc_nodes, vars = {SMODS.signed(cfg.extra.perma_mult)}}
        end
        if cfg.extra.perma_x_mult and cfg.extra.perma_x_mult > 0 then
            localize{type = 'other', key = 'kino_scifi_card_extra_xmult', nodes = desc_nodes, vars = {cfg.extra.perma_x_mult}}
        end
    end
end


SMODS.DrawStep {
    key = "kino_sci_fi_counter",
    order = 2,
    func = function(self, layer)
        if self and self.config.center == G.P_CENTERS.m_kino_sci_fi and G.shared_segdisp then
            if self.ability.extra.sprite_state == "level" then
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
                _values[2] = self.ability.extra.times_upgraded_ui % 10
                _values[1] = (self.ability.extra.times_upgraded_ui - _values[2]) / 10
                
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
            if self.ability.extra.sprite_state == "chips" then
                
            end

            -- Mult display
            if self.ability.extra.sprite_state == "mult" then
                
            end

        end
    end,
    conditions = {vortex = false, facing = 'front'}
}