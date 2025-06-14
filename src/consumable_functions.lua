G.FUNCS.can_pull_consumeable = function(e)
	if G.GAME.used_vouchers.v_kino_snackbag then
		if (#Kino.snackbag.cards < Kino.snackbag.config.card_limit) then
			e.config.colour = G.C.RED
			e.config.button = "pull_card"
		else
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		end
	elseif #G.consumeables.cards < G.consumeables.config.card_limit then
		e.config.colour = G.C.RED
        e.config.button = "pull_card"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.pull_card = function(e)
	local c1 = e.config.ref_table
	if e.config.activate then
		G.FUNCS.tape_activate(c1)
	end
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			c1.area:remove_card(c1)
			c1:add_to_deck()
			if c1.children.price then
				c1.children.price:remove()
			end
			c1.children.price = nil
			if c1.children.buy_button then
				c1.children.buy_button:remove()
			end
			c1.children.buy_button = nil
			remove_nils(c1.children)
			G.consumeables:emplace(c1)
			G.GAME.pack_choices = G.GAME.pack_choices - 1
			if G.GAME.pack_choices <= 0 then
				G.FUNCS.end_consumeable(nil, delay_fac)
			end
			return true
		end,
	}))
end
