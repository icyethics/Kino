if kino_config.confection_mechanic then
SMODS.Booster {
    key = "snack_booster_normal",
    kind = "confection",
    atlas = "kino_boosters",
    group_key = "snack_boosters",
    pos = {x = 0, y = 8},
    config = {
        extra = 3,
        choose = 1
    },
    cost = 3,
    order = 1,
    weight = 2,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local _card = create_card("confection", G.pack_cards, nil, nil, true, true, nil, nil)
        if G.GAME.used_vouchers.v_kino_special_treats then
            -- chance for golden 1/10
            -- chance for chocolate 1/10
            -- chance for XL 1/10 
            if pseudorandom("snack_boost_golden") < Kino.goldleaf_chance/10 then
                SMODS.Stickers['kino_goldleaf']:apply(_card, true)
            end
            if pseudorandom("snack_boost_choco") < Kino.choco_chance/10 then
                SMODS.Stickers['kino_choco']:apply(_card, true)
            end
            if pseudorandom("snack_boost_XL") < Kino.xl_chance/10 then
                SMODS.Stickers['kino_extra_large']:apply(_card, true)
            end
        end
        return _card
    end
}

SMODS.Booster {
    key = "snack_booster_jumbo",
    kind = "confection",
    atlas = "kino_boosters",
    group_key = "snack_boosters",
    pos = {x = 1, y = 8},
    config = {
        extra = 5,
        choose = 1
    },
    cost = 5,
    order = 1,
    weight = 1,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local _card = create_card("confection", G.pack_cards, nil, nil, true, true, nil, nil)
        if G.GAME.used_vouchers.v_kino_special_treats then
            -- chance for golden 1/10
            -- chance for chocolate 1/10
            -- chance for XL 1/10 
            if pseudorandom("snack_boost_golden") < Kino.goldleaf_chance/10 then
                SMODS.Stickers['kino_goldleaf']:apply(_card, true)
            end
            if pseudorandom("snack_boost_choco") < Kino.choco_chance/10 then
                SMODS.Stickers['kino_choco']:apply(_card, true)
            end
            if pseudorandom("snack_boost_XL") < Kino.xl_chance/10 then
                SMODS.Stickers['kino_extra_large']:apply(_card, true)
            end
        end
        return _card
    end
}

SMODS.Booster {
    key = "snack_booster_mega",
    kind = "confection",
    atlas = "kino_boosters",
    group_key = "snack_boosters",
    pos = {x = 2, y = 8},
    config = {
        extra = 5,
        choose = 2
    },
    cost = 7,
    order = 1,
    weight = 0.5,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local _card = create_card("confection", G.pack_cards, nil, nil, true, true, nil, nil)
        if G.GAME.used_vouchers.v_kino_special_treats then
            -- chance for golden 1/10
            -- chance for chocolate 1/10
            -- chance for XL 1/10 
            if pseudorandom("snack_boost_golden") < Kino.goldleaf_chance/10 then
                SMODS.Stickers['kino_goldleaf']:apply(_card, true)
            end
            if pseudorandom("snack_boost_choco") < Kino.choco_chance/10 then
                SMODS.Stickers['kino_choco']:apply(_card, true)
            end
            if pseudorandom("snack_boost_XL") < Kino.xl_chance/10 then
                SMODS.Stickers['kino_extra_large']:apply(_card, true)
            end
        end
        return _card
    end
}
end