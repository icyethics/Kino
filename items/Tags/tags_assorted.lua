SMODS.Tag {
    key = 'dinner',
    atlas = 'kino_tags',
    pos = {
        x = 0,
        y = 0
    },
    min_ante = 4,
    config = {
        type = 'immediate'
    },
    loc_vars = function(self, info_queue)
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
             tag:yep('+', G.C.GREEN, function()
                G.GAME.confections_powerboost = G.GAME.confections_powerboost + 1
                return true
            end)
            tag.triggered = true
            
        end
    end
}

SMODS.Tag {
    key = 'snacktag',
    atlas = 'kino_tags',
    pos = {
        x = 1,
        y = 0
    },
    min_ante = 1,
    config = {
        type = 'new_blind_choice'
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { set = "Other", key = "p_kino_snack_booster_mega", specific_vars = {2, 5}}
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_kino_snack_booster_mega', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}


SMODS.Tag {
    key = 'oscar',
    atlas = 'kino_tags',
    pos = {
        x = 2,
        y = 0
    },
    min_ante = 3,
    config = {
        type = 'new_blind_choice'
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { set = "Other", key = "p_kino_snack_booster_mega", specific_vars = {2, 5}}
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then

            local _validtargets = {}
            for _index, _joker in ipairs(G.jokers.cards) do
                if Cryptid and ( not _joker.ability.kino_award or
                G.GAME.used_vouchers.v_kino_egot) then
                    _validtargets[#_validtargets + 1] = _joker
                elseif _joker.config.center.kino_joker and ( not _joker.ability.kino_award or
                G.GAME.used_vouchers.v_kino_egot) then
                    _validtargets[#_validtargets + 1] = _joker
                end
            end

            if #_validtargets > 0 then
                tag:yep('+', G.C.GREEN, function()
                    for i = 1, 5 do
                        local _target = pseudorandom_element(_validtargets, pseudoseed("kino_awardstag"))
                        SMODS.Stickers['kino_award']:apply(_target, true)
                    end
                    return true
                end)
                tag.triggered = true
            end
            
        end
    end
}


SMODS.Tag {
    key = 'counter',
    atlas = 'kino_tags',
    pos = {
        x = 3,
        y = 0
    },
    min_ante = 1,
    config = {
        type = 'immediate'
    },
    loc_vars = function(self, info_queue)
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            tag:yep('+', G.C.GREEN, function()
                for i = 1, 5 do
                    local _target = pseudorandom_element(G.playing_cards, pseudoseed("kino_countertag"))
                    -- Kino.change_counters(_target, "kino_investment", 3)
                    _target:bb_counter_apply('counter_money', 3)
                end
                return true
            end)
            tag.triggered = true
        end
    end
}
