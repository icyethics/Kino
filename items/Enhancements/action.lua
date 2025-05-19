SMODS.Enhancement {
    key = "action",
    atlas = "kino_enhancements",
    pos = { x = 4, y = 1},
    config = {

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.repetition and context.cardarea == G.play and context.other_card == card then
            local _bullet_count = Kino.count_bullets()

            return {
                repetitions = _bullet_count,
                message = localize("k_action_card")
            }
        end
    end,
    -- update = function()
    --     -- DynaText({string = localize{type = 'name_text', set = self.config.center.set, key = self.config.center.key}, colours = {G.C.WHITE}, rotate = 1,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 0.6/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR})
    -- end
}

function Kino:count_bullets()
    local _bullet_count = 0
    -- bullet manipulation

    --
    for _, _card in ipairs(G.hand.cards) do
        if SMODS.has_enhancement(_card, "m_kino_action") then
            _bullet_count = _bullet_count + 1
        end
    end

    for _, _joker in ipairs(G.jokers.cards) do
        if _joker.config.center.kino_joker then
            if _joker.ability.extra and (_joker.ability.extra.bullet_count or _joker.ability.extra.bullet_count_non) then
                _bullet_count = _bullet_count + (_joker.ability.extra.bullet_count or _joker.ability.extra.bullet_count_non)
            end
        end
    end

    return _bullet_count
end