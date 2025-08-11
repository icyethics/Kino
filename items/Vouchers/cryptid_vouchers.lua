if Cryptid and Talisman then

    -- Implemented
if kino_config.confection_mechanic then
SMODS.Voucher {
    key = "confection_acclimator",
    atlas = "kino_cryptid_consumables",
    order = 9,
    set = "Voucher",
    pos = { x = 0, y = 2 },
    config = { extra = 24 / 4, extra_disp = 6 },
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    pools = { ["Tier3"] = true },
    	dependencies = {
		items = {
			"set_cry_tier3",
		},
	},
    requires = { "v_kino_confection_tycoon"},
    loc_vars = function(self, info_queue)
        return { vars = { card and card.ability.extra or self.config.extra_disp } }
    end,
    redeem = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME["confection_rate"] = G.GAME["confection_rate"] * self.config.extra
				return true
			end,
		}))
    end,
    unredeem = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME["confection_rate"] = G.GAME["confection_rate"] / self.config.extra
				return true
			end,
		}))
    end
}

    -- Implemented
SMODS.Voucher {
    key = "heavenly_treats",
    atlas = "kino_cryptid_consumables",
    order = 10,
    set = "Voucher",
    pos = { x = 1, y = 2 },
    config = { extra = 2, extra_disp = 100 },
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    pools = { ["Tier3"] = true },
    	dependencies = {
		items = {
			"set_cry_tier3",
		},
	},
    requires = { "v_kino_snackbag"},
    loc_vars = function(self, info_queue)
        return { vars = { self.config.extra, self.config.extra_disp } }
    end,
    redeem = function(self)

    end,
    unredeem = function(self)

    end
}
end

if kino_config.actor_synergy then
    -- Implemented
SMODS.Voucher {
    key = "egot",
    atlas = "kino_cryptid_consumables",
    order = 11,
    set = "Voucher",
    pos = { x = 2, y = 2 },
    config = { extra = 4 },
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    pools = { ["Tier3"] = true },
    	dependencies = {
		items = {
			"set_cry_tier3",
		},
	},
    requires = { "v_kino_awardsshow"},
    loc_vars = function(self, info_queue)
        return { vars = { self.config.extra } }
    end,
    redeem = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				Kino.awards_max = self.config.extra
				return true
			end,
		}))
    end,
    unredeem = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				Kino.awards_max = 1
				return true
			end,
		}))
    end
}

 -- Implemented
SMODS.Voucher {
    key = "datacenter",
    atlas = "kino_cryptid_consumables",
    order = 12,
    set = "Voucher",
    pos = { x = 3, y = 2 },
    config = { extra = 24 / 4, extra_disp = 6 },
    discovered = true,
    unlocked = true,
    available = true,
    cost = 10,
    pools = { ["Tier3"] = true },
    	dependencies = {
		items = {
			"set_cry_tier3",
		},
	},
    requires = { "v_kino_criterion_collection"},
    loc_vars = function(self, info_queue)
        return { vars = { card and card.ability.extra or self.config.extra_disp } }
    end,
    redeem = function(self)
        Kino.actor_synergy = {1, 1, 1.4, 1.8, 2.2, 2.6, 3, 3.5, 4, 5}
        Kino.genre_synergy_slots = 2
    end,
    unredeem = function(self)
        Kino.actor_synergy = {1, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.25, 2.5, 3}
        Kino.genre_synergy_slots = 1
    end
}
end
end