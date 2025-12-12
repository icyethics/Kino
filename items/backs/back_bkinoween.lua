SMODS.Back {
    name = "Pumpkin Deck",
    key = "kinoween_pumpkin",
    atlas = "kino_backs",
    pos = {x = 0, y = 3},
    config = {
    },
    apply = function()
        if kino_config.halloween_deck then
            G.GAME.modifiers.kinoween = true
            Kino.kinoween_ban_list()
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.repetition and not context.blueprint then
            for i = 1, (G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local card = create_card('confection', G.consumeables, nil, nil, nil, nil, "c_kino_candycorn", 'kinoween_pumpkin')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        card:juice_up(0.3, 0.5)
                    end
                    return true end }))
            end
            delay(0.6)
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_jumpscared_times and G.PROFILES[G.SETTINGS.profile].kino_jumpscared_times.count or 0
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_jumpscare' then
            if G.PROFILES[G.SETTINGS.profile].kino_jumpscared_times and G.PROFILES[G.SETTINGS.profile].kino_jumpscared_times.count >= 10 then
                unlock_card(self)
            end
        end
    end,
}

SMODS.Back {
    name = "Vampire Deck",
    key = "kinoween_vampire",
    atlas = "kino_backs",
    pos = {x = 1, y = 3},
    config = {
    },
    apply = function()

        if kino_config.halloween_deck then
            G.GAME.modifiers.kinoween = true
            Kino.kinoween_ban_list()
        end

        G.GAME.modifiers.kino_vampiredeck = true
        G.GAME.modifiers.kino_vampiredeck_rarity = 2

    end,
    calculate = function(self, card, context)
        -- When you play a single enhanced card, Drain it and give a random joker +20% power
        if context.before
        and context.full_hand
        and #context.full_hand == 1
        and not context.blueprint and not context.repetition then
            local _target = context.full_hand[1]
             if Kino.drain_property(_target, card, {Enhancement = {true}}) then
                local _valid_targets = {}
                for _index, _joker in ipairs(G.jokers.cards) do
                    if Blockbuster.is_value_manip_compatible(_joker) then
                        _valid_targets[#_valid_targets + 1] = _joker
                    end
                end

                if #_valid_targets > 0 then
                    local _target = pseudorandom_element(_valid_targets, pseudoseed("kinoween_vampire_deck"))
                    Blockbuster.manipulate_value(_target, "kinoween_vampire_deck", 0.2, nil, true)
                end
             end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            local _total_count = 0
            local _discovered_count = 0
            for i, _joker in pairs(G.P_CENTERS) do
                if kino_quality_check(_joker, 'is_vampire') then
                    _total_count = _total_count + 1
                    if _joker.discovered then
                        _discovered_count = _discovered_count + 1
                    end
                end
            end

            if _total_count == _discovered_count then
                unlock_card(self)
            end
        end
    end,
}

function Kino.kinoween_ban_list()
    local _added_values = {
        -- Blinds
        bl_ox = true,
        bl_mouth = true,
        bl_fish = true,
        bl_club = true,
        bl_manacle = true,
        bl_tooth = true,
        bl_wall = true,
        bl_house = true,
        bl_mark = true,
        bl_wheel = true,
        bl_arm = true,
        bl_goad = true,
        bl_water = true,
        bl_plant = true,
        bl_head = true,
        bl_window = true,
        bl_pillar = true,
        bl_flint = true,

        -- Tags
        tag_uncommon = true,
        tag_rare = true,
        tag_negative = true,
        tag_foil = true,
        tag_holo = true,
        tag_polychrome = true,
        tag_investment = true,
        tag_voucher = true,
        tag_boss = true,
        tag_standard = true,
        tag_charm = true,
        tag_meteor = true,
        tag_buffoon = true,
        tag_handy = true,
        tag_garbage = true,
        tag_ethereal = true,
        tag_coupon = true,
        tag_double = true,
        tag_juggle = true,
        tag_d_six = true,
        tag_top_up = true,
        tag_skip = true,
        tag_orbital = true,
        tag_economy = true,
        -- Kino Tags
        tag_kino_counter = true,
        tag_kino_oscar = true,
        tag_kino_snacktag = true,
        tag_kino_dinner = true
        -- Centers

    }

    for _key, _bool in pairs(_added_values) do
        G.GAME.banned_keys[_key] = true
    end
    
end