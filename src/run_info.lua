function create_UIBox_quest_log(simple)
	
	-- 4 or 5 Quest jokers per screen
	-- Sorted by quest completion order

	-- Gather legendary jokers
	local _questjokers_ui_elements = {}
	local questjokerpages = {}
	local questjokers_per_page = 4

	

	for i = 1, 4 do
	
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

		-- DEBUG COLOURS
		local _colourdebug = G.C.CLEAR
		local _aligndebug = "cm"


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
									colour = G.C.RED
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



function create_UIBox_your_collection_jokers()
  local deck_tables = {}

  G.your_collection = {}
  for j = 1, 3 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      5*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[j]}}
    }}
    )
  end

  local joker_options = {}
  for i = 1, math.ceil(#G.P_CENTER_POOLS.Joker/(5*#G.your_collection)) do
    table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.P_CENTER_POOLS.Joker/(5*#G.your_collection))))
  end

  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTER_POOLS["Joker"][i+(j-1)*5]
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      card.sticker = get_joker_win_sticker(center)
      G.your_collection[j]:emplace(card)
    end
  end

  INIT_COLLECTION_CARD_ALERTS()
  
  local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_joker_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }}
    }})
  return t
end

-- function G.UIDEF.used_vouchers()

--   local silent = false
--   local keys_used = {}
--   local area_count = 0
--   local voucher_areas = {}
--   local voucher_tables = {}
--   local voucher_table_rows = {}

--   for k, v in ipairs(G.P_CENTER_POOLS["Voucher"]) do
--     local key = 1 + math.floor((k-0.1)/2)
--     keys_used[key] = keys_used[key] or {}
--     if G.GAME.used_vouchers[v.key] then 
--       keys_used[key][#keys_used[key]+1] = v
--     end
--   end

--   for k, v in ipairs(keys_used) do 
--     if next(v) then
--       area_count = area_count + 1
--     end
--   end

--   for k, v in ipairs(keys_used) do 
--     if next(v) then

-- 		if #voucher_areas == 5 or #voucher_areas == 10 then 
-- 			table.insert(voucher_table_rows, 
-- 			{n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
-- 			)
-- 			voucher_tables = {}
-- 		end

-- 		voucher_areas[#voucher_areas + 1] = CardArea(
-- 				G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
-- 				(#v == 1 and 1 or 1.33)*G.CARD_W,
-- 				(area_count >=10 and 0.75 or 1.07)*G.CARD_H, 
-- 				{card_limit = 2, type = 'voucher', highlight_limit = 0}
-- 		)

-- 		for kk, vv in ipairs(v) do 
-- 			local center = G.P_CENTERS[vv.key]
-- 			local card = Card(
-- 				voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, 
-- 				voucher_areas[#voucher_areas].T.y, 
-- 				G.CARD_W, 
-- 				G.CARD_H, 
-- 				nil, 
-- 				center, 
-- 				{
-- 					bypass_discovery_center=true,
-- 					bypass_discovery_ui=true,
-- 					bypass_lock=true
-- 				}
-- 			)
-- 			card.ability.order = vv.order
-- 			card:start_materialize(nil, silent)
-- 			silent = true
-- 			voucher_areas[#voucher_areas]:emplace(card)

-- 		end
-- 		table.insert(voucher_tables, 
-- 		{n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
-- 			{n=G.UIT.O, config={object = voucher_areas[#voucher_areas]}}
-- 		}}
-- 		)
-- 		end
-- 	end
--   table.insert(voucher_table_rows,
--           {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
--         )

  
--   local t = silent and {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes=
--   {
--     {n=G.UIT.R, config={align = "cm"}, nodes={
--       {n=G.UIT.O, config={object = DynaText({string = {localize('ph_vouchers_redeemed')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
--     }},
--     {n=G.UIT.R, config={align = "cm", minh = 0.5}, nodes={
--     }},
--     {n=G.UIT.R, config={align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05}, nodes={
--       {n=G.UIT.R, config={align = "cm"}, nodes=voucher_table_rows},
--     }}
--   }} or 
--   {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
--     {n=G.UIT.O, config={object = DynaText({string = {localize('ph_no_vouchers')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
--   }}
--   return t
-- end