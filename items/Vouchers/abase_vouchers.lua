if kino_config.confection_mechanic then
SMODS.Voucher {
    key = "confection_merchant",
    atlas = "kino_vouchers",
    order = 1,
    set = "Voucher",
    pos = { x = 0, y = 0 },
    config = {increase = 2},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {self.config.increase} }
    end,
    redeem = function(self)
        G.GAME["confection_rate"] = G.GAME["confection_rate"]* self.config.increase
    end,
    unredeem = function(self)
        G.GAME["confection_rate"]= G.GAME["confection_rate"]/ self.config.increase
    end
}

SMODS.Voucher {
    key = "confection_tycoon",
    atlas = "kino_vouchers",
    order = 2,
    set = "Voucher",
    pos = { x = 0, y = 1 },
    config = {increase = 2, total = 4},
    discovered = true,
    unlocked = true,
    available = true,
    requires = { "v_kino_confection_merchant"},
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {self.config.total} }
    end,
    redeem = function(self)
        G.GAME["confection_rate"]= G.GAME["confection_rate"]* self.config.increase
    end,
    unredeem = function(self)
        G.GAME["confection_rate"]= G.GAME["confection_rate"]/ self.config.increase
    end
}

SMODS.Voucher {
    key = "special_treats",
    atlas = "kino_vouchers",
    order = 3,
    set = "Voucher",
    pos = { x = 1, y = 0 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end
}

SMODS.Voucher {
    key = "snackbag",
    atlas = "kino_vouchers",
    order = 4,
    set = "Voucher",
    pos = { x = 1, y = 1 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    requires = { "v_kino_special_treats"},
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end
}
end

if kino_config.actor_synergy then
SMODS.Voucher {
    key = "awardsbait",
    atlas = "kino_vouchers",
    order = 5,
    set = "Voucher",
    pos = { x = 2, y = 0 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end
}

SMODS.Voucher {
    key = "awardsshow",
    atlas = "kino_vouchers",
    order = 6,
    set = "Voucher",
    pos = { x = 2, y = 1 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    requires = { "v_kino_awardsbait"},
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and 
        context.main_eval and not context.repetition and not context.individual then
            local _targets = {}

            for _, _joker in ipairs(G.jokers.cards) do
                if not Cryptid then
                    if _joker.config.center.k_genre and G.GAME.used_vouchers.v_kino_egot then
                        _targets[#_targets + 1] = _joker
                    end

                    if _joker.config.center.k_genre and not _joker.ability.kino_award then
                        _targets[#_targets + 1] = _joker
                    end
                end
                if Cryptid and Talisman then
                    if  G.GAME.used_vouchers.v_kino_egot then
                        _targets[#_targets + 1] = _joker
                    end

                    if not _joker.ability.kino_award then
                        _targets[#_targets + 1] = _joker
                    end
                end
            end

            if #_targets > 0 then
                local _target = pseudorandom_element(_targets, pseudoseed("awards"))

                SMODS.Stickers['kino_award']:apply(_target, true)
            end
        end
    end
}


SMODS.Voucher {
    key = "media_collection",
    atlas = "kino_vouchers",
    order = 7,
    set = "Voucher",
    pos = { x = 3, y = 0 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end,
    redeem = function(self)
        G.GAME.current_round["genre_synergy_treshold"] = G.GAME.current_round["genre_synergy_treshold"] - 1
        G.GAME.current_round["actors_check"] = G.GAME.current_round["actors_check"] - 1
        G.GAME.current_round["actors_table_offset"] = G.GAME.current_round["actors_table_offset"] + 1
    end,
    unredeem = function(self)
        G.GAME.current_round["genre_synergy_treshold"] = G.GAME.current_round["genre_synergy_treshold"] + 1
        G.GAME.current_round["actors_check"] = G.GAME.current_round["actors_check"] + 1 
        G.GAME.current_round["actors_table_offset"] = G.GAME.current_round["actors_table_offset"] - 1
    end
}

SMODS.Voucher {
    key = "criterion_collection",
    atlas = "kino_vouchers",
    order = 8,
    set = "Voucher",
    pos = { x = 3, y = 1 },
    config = {},
    discovered = true,
    unlocked = true,
    available = true,
    requires = { "v_kino_media_collection"},
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end,
    redeem = function(self)
        G.GAME.current_round["genre_synergy_treshold"] = G.GAME.current_round["genre_synergy_treshold"] - 1
        G.GAME.current_round["actors_check"] = G.GAME.current_round["actors_check"] - 1
        G.GAME.current_round["actors_table_offset"] = G.GAME.current_round["actors_table_offset"] + 1
    end,
    unredeem = function(self)
        G.GAME.current_round["genre_synergy_treshold"] = G.GAME.current_round["genre_synergy_treshold"] + 1
        G.GAME.current_round["actors_check"] = G.GAME.current_round["actors_check"] + 1 
        G.GAME.current_round["actors_table_offset"] = G.GAME.current_round["actors_table_offset"] - 1
    end
}
end