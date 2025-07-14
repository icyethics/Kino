-- these functions target the genre deck so you can choose a specific deck for it to interact with

-- Code is modified and based on Cryptid's enhanced deck functionality. Specifically 'enhanced.lua', line 416-541
function Kino.safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

local o_cc = Card.click
function Card:click()
    o_cc(self)
    if
        Galdur
            and Kino.safe_get(Galdur, "run_setup", "current_page") == 1
            and (self.edeck_select or (self.area == Kino.safe_get(Galdur, "run_setup", "selected_deck_area") and Kino.safe_get(
                self,
                "config",
                "center",
                "genre_deck"
            )))
        or not Galdur
            and (Kino.safe_get(G.GAME, "viewed_back", "effect", "center", "genre_deck") and (self.back == "viewed_back" or self.edeck_select))
    then
        if not G.cry_edeck_select then
            Kino.enhancement_config_UI(Galdur and self.config.center or G.GAME.viewed_back.effect.center, 1)
            G.cry_edeck_select = true
            G.cry_edeck_center = Galdur and self.config.center or G.GAME.viewed_back.effect.center
        else
            if self.edeck_select then
                G.PROFILES[G.SETTINGS.profile]["cry_edeck_" .. self.config.center.edeck_type] =
                    self.edeck_select
            end
            G.FUNCS.overlay_menu({
                definition = G.UIDEF.run_setup("main_menu_play"),
            })
            G.cry_edeck_select = nil
            G.cry_edeck_center = nil
        end
    end
end

function Kino.enhancement_config_UI(center, actual_page)
    local count_per_page = 6
    if not center.edeck_type then
        return
    end
    G.SETTINGS.paused = true
    G.your_collection = {}
    G.your_collection[1] = CardArea(
        G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
        G.ROOM.T.h,
        5.3 * G.CARD_W,
        1.03 * G.CARD_H,
        { card_limit = 5, type = "title", highlight_limit = 0, collection = true }
    )
    local deck_tables = {
        n = G.UIT.R,
        config = { align = "cm", padding = 0, no_fill = true },
        nodes = {
            { n = G.UIT.O, config = { object = G.your_collection[1] } },
        },
    }

    local pool_table = {
        edition = G.P_CENTER_POOLS.Edition,
        enhancement = G.P_CENTER_POOLS.Enhanced,
        sticker = SMODS.Stickers,
        suit = SMODS.Suits,
        seal = G.P_SEALS,
    }
    local editions = {}
    for i, v in pairs(pool_table[center.edeck_type]) do
        if v.key ~= "e_base" and not v.no_edeck then
            editions[#editions + 1] =
                { index = i, center = (center.edeck_type == "edition" and v.key:sub(3)) or v.key }
        end
    end
    local page = (actual_page and actual_page * count_per_page or count_per_page) - (count_per_page - 1)
    local max_pages = math.floor(#editions / count_per_page)
    if max_pages * count_per_page < #editions then --idk why this is needed but it is
        max_pages = max_pages + 1
    end
    local modification_options = {}
    for i = 1, max_pages do
        table.insert(
            modification_options,
            localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(max_pages)
        )
    end
    for i = page, math.min(page + count_per_page - 1, #editions) do
        local _center = Cryptid.deep_copy(center)
        _center.config["cry_force_" .. center.edeck_type] = editions[i].center
        Cryptid.edeck_atlas_update(_center)
        local card = Cryptid.generic_card(_center)
        card.edeck_select = editions[i].center
        G.your_collection[1]:emplace(card)
    end

    INIT_COLLECTION_CARD_ALERTS()

    local t = create_UIBox_generic_options({
        --infotip = localize("cry_gameset_explanation"),
        back_func = "setup_run",
        snap_back = true,
        contents = {
            {
                n = G.UIT.R,
                config = { align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
                nodes = { deck_tables },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    create_option_cycle({
                        options = modification_options,
                        w = 4.5,
                        cycle_shoulders = true,
                        opt_callback = "edeck_page",
                        current_option = actual_page,
                        colour = G.C.RED,
                        no_pips = true,
                        focus_args = { snap_to = true, nav = "wide" },
                    }),
                },
            },
        },
    })
    G.FUNCS.overlay_menu({
        definition = t,
    })
    end
    G.FUNCS.edeck_page = function(args)
    Cryptid.enhancement_config_UI(G.cry_edeck_center, args.cycle_config.current_option)
end