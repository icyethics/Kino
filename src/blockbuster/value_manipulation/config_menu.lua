local config_toggles = {
	-- Mod Mechanics
	{ref_value = "debug_print", label = "blockbuster_config_debug_print"},
	{ref_value = "compat_box", label = "blockbuster_config_compat_box"},
	{ref_value = "display_current_boost", label = "blockbuster_config_display_current_boost"}
}


local create_menu_toggles = function (parent, toggles)
	for k, v in ipairs(toggles) do
		parent.nodes[#parent.nodes + 1] = create_toggle({
				label = localize(v.label),
				ref_table = Blockbuster.ValueManipulation_config,
				ref_value = v.ref_value,
				callback = function(_set_toggle)
				NFS.write(Blockbuster.ValueManipulation.mod_dir.."/config.lua", STR_PACK(Blockbuster.ValueManipulation_config))
				end,
		})
		if v.tooltip then
			parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
		end
	end
end

Blockbuster.ValueManipulation.config_page = function()
	local config_toggle_nodes = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_toggles(config_toggle_nodes, config_toggles)


	local config_nodes =
	{
		{
			n = G.UIT.R,
			config = {
				padding = 0,
				align = "tm"
			},
			nodes = {
				-- Column Left
				{
					n = G.UIT.C,
					config = {
						padding = 0,
						align = "tm"
					},
					nodes = {
						-- HEADER (ENHANCEMENT TYPES)
						{
							n = G.UIT.R,
							config = {
								padding = 0,
								align = "cm"
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("blockbuster_config_header"),
										shadow = true,
										scale = 0.75 * 0.8,
										colour = HEX("ED533A")
									}
								}
							},
						},
						config_toggle_nodes,
					}
				},
			},
		},
	}

	return config_nodes
end

SMODS.current_mod.config_tab = function()
	return {
		n = G.UIT.ROOT, 
		config = {        
			align = "cm",
        	padding = 0.05,
        	colour = G.C.CLEAR,
		}, 
		nodes = Blockbuster.ValueManipulation.config_page()
	}
end
