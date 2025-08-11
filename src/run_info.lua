function create_UIBox_quest_log(simple)
	
	-- 4 or 5 Quest jokers per screen
	-- Sorted by quest completion order

	-- Gather legendary jokers
	local _questjokers_ui_elements = {}
	local questjokerpages = {}
	local questjokers_per_page = 4

	

	for i = 1, 5 do
	
		-- Create Card Area to place card
		local _questarea = CardArea(
			G.ROOM.T.x + 0.2*G.ROOM.T.w/2,
			G.ROOM.T.h,
			G.CARD_W, 
			G.CARD_H,  
			{card_limit = 1, type = 'title', highlight_limit = 0, collection = true}
		)

		-- Gather card
		local _center = G.P_CENTERS["j_kino_" .. Kino.legendaries[i]]
		-- local _center = G.P_CENTERS.j_kino_barbie
		local _card =  Card(
			_questarea.T.x + _questarea.T.w/2, 
			_questarea.T.y, 
			G.CARD_W, 
			G.CARD_H, 
			nil, 
			_center,
			{bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true}
		)
		-- 
		_card.ambient_tilt = 0
		_card.states.visible = true
		_card:start_materialize(nil, true)
		_questarea:emplace(_card)

		local _questcompletion = 0
		local garbage = nil
		if _center then
			garbage, _questcompletion = _center:legendary_conditions(self, _center)
		end
		
		local _text = _questcompletion .. " / 6"
		local _textcolour = G.C.WHITE
		local current_rarity = 6 - _questcompletion
		-- DEBUG COLOURS
		local _colourdebug = G.C.CLEAR
		local _aligndebug = "cm"
		if current_rarity > 3 then
			current_rarity = 4
		elseif current_rarity <= 0 then
			current_rarity = 1
		end

		-- Create UI object
		local _questjokerobject = {
			n = G.UIT.C,
			config = {
				align = "cm", 
				padding = 0,
				no_fill = true,
				colour = G.C.CLEAR
			},
			nodes = {
				-- Joker
				{
					n = G.UIT.R,
					config = 
						{ 
							align = "cm", 
							padding = 0.04, 
							colour = G.C.CLEAR
						},
					nodes = {
						{
							n=G.UIT.O,
							config = {
								object = _questarea
							}
						}
					}
				},
				-- Quest button 
				{
					n = G.UIT.R,
					config = 
						{ 
							minw = G.CARD_W,
							align = _aligndebug, 
							colour = G.C.CLEAR
						},
					nodes = {
						{
							n = G.UIT.C,
							config = 
								{ 
									align = _aligndebug, 
									padding = 0.1,
									minw = 1.7,
									minh = 0.4,
									r = 0.1, 
									colour = G.C.RARITY[current_rarity]
								},
							nodes = {
								-- Text object
								{
									n = G.UIT.T,
									config = {
										text = _text,
										colour = _textcolour, 
										scale = 0.5, 
										shadow = false
									}
								}
							}
						}
					}
				}
			}
		}

		table.insert(_questjokers_ui_elements, _questjokerobject)
	end

	local _textobjects = {}

	 for _index, _text in ipairs(localize("k_kino_legendary_quest_tutorial")) do
		local _textnode = {
			n = G.UIT.R,
			config = {
				align = 'cm',
				colour = G.C.CLEAR,
			},
			nodes = {
				{n = G.UIT.T,
				config = {
					text = _text,
					colour = G.C.WHITE, 
					scale = 0.6, 
					shadow = false
				}}
			}  
		}

		_textobjects[#_textobjects + 1] = _textnode
	end

	local t = {
		n = G.UIT.ROOT,
		config = { 
			align = "cm",
			minw = 10.3,
			minh = 8, 
			padding = 0.1, 
			r = 0.1, 
			colour = G.C.WHITE 
		},
		nodes = {
			{
				n=G.UIT.C, 
				config= {
					align = "cm", 
					minw = 10,
					minh = 7.7, 
					colour = G.C.BLACK, 
					r = 1, 
					padding = 0.15, 
					emboss = 0.05
				}, 
				nodes={
					-- Text With Explanation
					{
						n=G.UIT.R, 
						config = {
							align = "tm",
							colour = G.C.CLEAR
						}, 
						nodes = _textobjects
					},

					-- Joker Info
					{
						n=G.UIT.R, 
						config = {
							align = "cm",
							colour = G.C.CLEAR
						}, 
						nodes = _questjokers_ui_elements
					},
				}
			}
		}
	}
	return t
end

G.FUNCS.quest_log = function(e, simple)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu{
    definition = create_UIBox_quest_log(simple),
  }
end
