if kino_config.spellcasting then
	function create_UIBox_spells()
		local _pool = {}
		for i, v in pairs(SMODS.Spells) do
			_pool[i] = v
		end

		return SMODS.card_collection_UIBox(_pool, { 5, 5 }, {
			snap_back = true,
			hide_single_page = true,
			collapse_single_page = true,
			-- center = 'c_base',
			h_mod = 1.03,
			back_func = 'your_collection_other_gameobjects',
			modify_card = function(card, center)
				card.ignore_pinned = true
				-- center:apply(card, true)
			end,
		})
	end

	SMODS.current_mod.custom_collection_tabs = function()
		return {
			UIBox_button({
				button = 'your_collection_spells', 
				label = {'Spells'}, 
				minw = 5,
				minh = 1, 
				id = 'your_collection_spells', 
				focus_args = {snap_to = true}
			})
		}
	end

	G.FUNCS.your_collection_spells = function()
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu{
			definition = create_UIBox_spells(),
		}
	end


	SMODS.Keybind({
    key_pressed = "s",
    action = function(self)
        local selected = G and G.CONTROLLER and
            (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end

        Kino.create_overylay_spell_showcase()
    end
	})

	-- Spell UI
	
end

----- CONFIG UI -----
--- CODE ADAPTED FROM POKERMON ---
local enhancement_types_toggles = {
	-- Enhancement Types
	{ref_value = "sci_fi_enhancement", label = "kino_settings_sci_fi_enhancement"},
	{ref_value = "spellcasting", label = "kino_settings_spellcasting"},
	{ref_value = "demonic_enhancement", label = "kino_settings_demonic_enhancement"},
	{ref_value = "horror_enhancement", label = "kino_settings_horror_enhancement"},
	{ref_value = "romance_enhancement", label = "kino_settings_romance_enhancement"},
	{ref_value = "action_enhancement", label = "kino_settings_action_enhancement"},
	{ref_value = "crime_enhancement", label = "kino_settings_crime_enhancement"}
}
local joker_mechanics_toggles = {
	-- Joker Mechanics
	{ref_value = "jumpscare_mechanic", label = "kino_settings_jumpscare_mechanic"},
	{ref_value = "vampire_jokers", label = "kino_settings_vampire_jokers"},
	{ref_value = "time_based_jokers", label = "kino_settings_time_based_jokers"},
	{ref_value = "confection_mechanic", label = "kino_settings_confection_mechanic"}
}
local mod_mechanics_toggles = {
	-- Mod Mechanics
	{ref_value = "actor_synergy", label = "kino_settings_actor_synergy"},
	{ref_value = "genre_synergy", label = "kino_settings_genre_synergy"},
	{ref_value = "movie_jokers_only", label = "kino_settings_movie_jokers_only"},
	{ref_value = "custom_rarity", label = "kino_settings_custom_rarity"},
}

local mod_mechanics_sliders = {
	{ref_value = "speed_factor", label = "kino_settings_speed_factor"}
}

local create_menu_toggles = function (parent, toggles)
	for k, v in ipairs(toggles) do
		parent.nodes[#parent.nodes + 1] = create_toggle({
				label = localize(v.label),
				ref_table = kino_config,
				ref_value = v.ref_value,
				callback = function(_set_toggle)
				NFS.write(Kino.mod_dir.."/config.lua", STR_PACK(kino_config))
				end,
		})
		if v.tooltip then
			parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
		end
	end
end

local create_menu_sliders = function(parent, sliders)
	for k, v in ipairs(sliders) do
		parent.nodes[#parent.nodes + 1] = create_slider({
			label = localize(v.label),
			label_scale = 0.4,
			text_scale = 0.3,
			w = 4,
			h = 0.4,
			ref_table = kino_config,
			ref_value = v.ref_value,
			min = 10,
			max = 300,
		})
		if v.tooltip then
			parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
		end
	end
end

kinoconfig = function()
	local enhancement_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_toggles(enhancement_settings, enhancement_types_toggles)
	
	local joker_mechanics_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_toggles(joker_mechanics_settings, joker_mechanics_toggles)
	
	local mod_mechanics_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_toggles(mod_mechanics_settings, mod_mechanics_toggles)

	local mod_mechanics_settings_2 = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_sliders(mod_mechanics_settings_2, mod_mechanics_sliders)

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
										text = localize("kino_settings_header_enhancements"),
										shadow = true,
										scale = 0.75 * 0.8,
										colour = HEX("ED533A")
									}
								}
							},
						},
						enhancement_settings,
					}
				},

				-- Column Right
				{
					n = G.UIT.C,
					config = {
						padding = 0,
						align = "tm"
					},
					nodes = {
						-- HEADER (mod_mechanics_settings)
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
										text = localize("kino_settings_header_mod_mechanics"),
										shadow = true,
										scale = 0.75 * 0.8,
										colour = HEX("ED533A")
									}
								}
							},
						},
						mod_mechanics_settings,
						
						-- HEADER (joker_mechanics_settings)
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
										text = localize("kino_settings_header_joker_mechanics"),
										shadow = true,
										scale = 0.75 * 0.8,
										colour = HEX("ED533A")
									}
								}
							},
						},
						joker_mechanics_settings
					}
				}
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
		nodes = kinoconfig()
	}
end

----- Additional Modpage UI -----

SMODS.current_mod.extra_tabs = function()
	local scale = 0.75
	return {
		label = localize("kino_credits_header"),
		tab_definition_function = function()
			return {
				n = G.UIT.ROOT,
				config = {
				align = "cm",
				padding = 0.05,
				colour = G.C.CLEAR,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = {
							padding = 0,
							align = "cl"
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("kino_credits_developer"),
									shadow = true,
									scale = scale * 0.8,
									colour = G.C.UI.TEXT_LIGHT
								}
							},
							{
								n = G.UIT.T,
								config = {
									text = "IcyEthics",
									shadow = true,
									scale = scale * 0.8,
									colour = G.C.BLUE
								}
							}
						}
					},
					{
						n = G.UIT.R,
						config = {
							padding = 0,
							align = "cl",
							scale = scale * 0.6,
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("kino_credits_specialthanks"),
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.UI.TEXT_LIGHT
								}
							},
							{
								n = G.UIT.T,
								config = {
									text = "Alphapra",
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.BLUE
								}
							}
						}
					},
					{
						n = G.UIT.R,
						config = {
							padding = 0,
							align = "cl",
							scale = scale * 0.6,
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("kino_credits_programminghelp"),
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.UI.TEXT_LIGHT
								}
							},
							{
								n = G.UIT.T,
								config = {
									text = "Dilly_the_Dillster",
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.BLUE
								}
							}
							,
							{
								n = G.UIT.T,
								config = {
									text = ", HarmoniousJoker",
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.BLUE
								}
							}
							,
							{
								n = G.UIT.T,
								config = {
									text = ", strmnn",
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.BLUE
								}
							}
						}
					},
					{
						n = G.UIT.R,
						config = {
							padding = 0,
							align = "cl",
							scale = scale * 0.6,
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("kino_credits_wiki"),
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.UI.TEXT_LIGHT
								}
							},
							{
								n = G.UIT.T,
								config = {
									text = "Doctor Flamingo",
									shadow = true,
									scale = scale * 0.5,
									colour = G.C.BLUE
								}
							}
						}
					},
					{
						n = G.UIT.R,
						config = {
							padding = 0.2,
							align = "cm",
						},
						nodes = {
							UIBox_button({
								minw = 3.85,
								button = "kino_github",
								label = {"Github"}
							}),
							UIBox_button({
								minw = 3.85,
								colour = HEX("9656ce"),
								button = "kino_discord",
								label = {"Discord"}
							}),
							UIBox_button({
								minw = 3.85,
								colour = G.C.MONEY,
								button = "kino_wiki",
								label = {"Wiki"}
							})
						}
					}
				}
			}
		end
	}
end
-- Alphapra
-- Dilly the Dillster
-- Doctor Flamingo
function G.FUNCS.kino_github(e)
	love.system.openURL("https://github.com/icyethics/Kino")
end
function G.FUNCS.kino_discord(e)
	love.system.openURL("https://discord.gg/jQQKUurk8K")
end
function G.FUNCS.kino_wiki(e)
	love.system.openURL("https://balatromods.miraheze.org/wiki/Balatro_Goes_Kino")
end

