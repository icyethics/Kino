SMODS.Keybind({
    key_pressed = "f",
    action = function(self)
        local selected = G and G.CONTROLLER and
            (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end
        if selected and selected.config and selected.config.center and
        selected.config.center.set == 'ContentPackage' then
            G.SETTINGS.paused = true
            G.FUNCS.overlay_menu{
                definition = Blockbuster.Playset.create_content_showcase(selected),
            }
        end
    end
})

function Blockbuster.Playset.create_content_showcase(content_package)

    Blockbuster.list_of_centers = {}
    Blockbuster.showcase_package_image = content_package.config.center
    for _key, _center in pairs(G.P_CENTERS) do
        if _center == content_package.config.center then
            print("DANGER, CONTENT PACKAGE CENTERS ARE ADDED TO G.P_CENTERS")
        elseif content_package.config.center.items[_key] and not _center.no_collection then
            Blockbuster.list_of_centers[#Blockbuster.list_of_centers + 1] = _center
        end
    end

    -- matching jokers for right view
    local deck_tables = {}
    Blockbuster.card_center_card_area = {}
    for j = 1, 3 do
        Blockbuster.card_center_card_area[j] = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        5*G.CARD_W,
        0.95*G.CARD_H, 
        {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
        table.insert(deck_tables, 
            {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
            {n=G.UIT.O, config={object = Blockbuster.card_center_card_area[j]}}
            }}
        )
    end

    -- Showcase joker for left view
    local showcase_jokers = {}
    Blockbuster.content_package_area = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        1*G.CARD_W,
        0.95*G.CARD_H, 
        {card_limit = 1, type = 'title', highlight_limit = 0, collection = true}
    )
    table.insert(showcase_jokers, 
        {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
        {n=G.UIT.O, config={object =  Blockbuster.content_package_area}}
        }}
    )
    local showcase_card = Card(Blockbuster.content_package_area.T.x + Blockbuster.content_package_area.T.w/2, Blockbuster.content_package_area.T.y, G.CARD_W, G.CARD_H, nil, Blockbuster.showcase_package_image)
    Blockbuster.content_package_area:emplace(showcase_card)


    local joker_options = {}
    for i = 1, math.ceil(#Blockbuster.list_of_centers/(5*#Blockbuster.card_center_card_area)) do
        table.insert(joker_options, localize('k_blockbuster_included_cards')..' '..tostring(i)..'/'..tostring(math.ceil(#Blockbuster.list_of_centers/(5*#Blockbuster.card_center_card_area))))
    end

    for i = 1, 5 do
        for j = 1, #Blockbuster.card_center_card_area do
            local center = Blockbuster.list_of_centers[i+(j-1)*5]
            if not center then break end
            local card = Card(Blockbuster.card_center_card_area[j].T.x + Blockbuster.card_center_card_area[j].T.w/2, Blockbuster.card_center_card_area[j].T.y, G.CARD_W, G.CARD_H, nil, center)
            card.sticker = get_joker_win_sticker(center)
            Blockbuster.card_center_card_area[j]:emplace(card)
        end
    end

    local _metadata_nodes = {}
    local _metadata_entries = content_package.config.center.sets

    local _infonode = {
            n = G.UIT.R,
            config = {align = "cm", colour = G.C.BLACK, r = 0.01, padding = 0.07},
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        align = "cm", 
                        colour = G.C.WHITE,
                        scale = 0.3,
                        text = localize({type='name_text', set='ContentPackage', key=Blockbuster.showcase_package_image.key})
                        -- text = "Truly just a test text"
                    }
                }
            }
        }

    local _description_text = localize({type='description_text', set='ContentPackage', key=Blockbuster.showcase_package_image.key})
    print(_description_text)
    table.insert(_metadata_nodes, _infonode)

    for _, _key in ipairs(_metadata_entries) do
        local _count = 0

        for _index2, _object in ipairs(Blockbuster.list_of_centers) do
            if _object.set == _key then
                _count = _count + 1
            end
        end

        local _node =  {
            n = G.UIT.R,
            config = {align = "cm", colour = G.C.BLACK, r = 0.01, padding = 0.07},
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        align = "cm", 
                        colour = G.C.WHITE,
                        scale = 0.3,
                        text = _metadata_entries[_] .. "s: " .. tostring(_count)
                        -- text = "Truly just a test text"
                    }
                }
            }
        }
        table.insert(_metadata_nodes, _node)
    end
    
    local t =  create_UIBox_generic_options({ back_func = 'your_collection_content_packages', contents = {
            { 
                n= G.UIT.R, 
                config = {align = "cm"}, 
                nodes = {
                    -- Left column
                    {
                        n = G.UIT.C,
                        config = { align = "cm", colour = G.C.CLEAR, padding = 0.1},
                        nodes = {
                            -- Title thing
                            {
                                n = G.UIT.R, 
                                config = { align = "cm", r = 0.1, colour = G.C.WHITE, emboss = 0.05},
                                nodes = {
                                    {n = G.UIT.T,
                                        config = {
                                            text = "Content Package",
                                            align = "cm",
                                            colour = G.C.L_BLACK, 
                                            scale = 0.5, 
                                            shadow = false
                                        }
                                    },
                                }
                            },
                            -- Joker
                            {
                                n = G.UIT.R, 
                                config = { align = "cm", r = 0.1, colour = G.C.WHITE, emboss = 0.05},
                                nodes = showcase_jokers
                            },
                            -- Movie Info
                            {
                                n = G.UIT.R, 
                                config = { align = "cm", r = 0.1, emboss = 0.05},
                                nodes = {
                                    {
                                        n = G.UIT.C,
                                        config = { align = "lm", colour = G.C.CLEAR, padding = 0.1},
                                        nodes = _metadata_nodes
                                    }
                                }
                            }
                        }
                    },
                    -- Middle padding
                    {
                        n = G.UIT.C,
                        config = { align = "cm", colour = G.C.CLEAR, w = 1}
                    },
                    -- Right column
                    {
                        n = G.UIT.C,
                        config = { align = "cr", colour = G.C.CLEAR},
                        nodes = {
                            {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
                            {n=G.UIT.R, config={align = "cm"}, nodes={
                            create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'kino_actor_matching_joker_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
                            }}
                        }
                    },

                },
            }
        }})

    return t
end

G.FUNCS.kino_actor_matching_joker_page = function(args)
  if not args or not args.cycle_config then return end

  for j = 1, #Blockbuster.card_center_card_area do
    for i = #Blockbuster.card_center_card_area[j].cards,1, -1 do
      local c = Blockbuster.card_center_card_area[j]:remove_card(Blockbuster.card_center_card_area[j].cards[i])
      c:remove()
      c = nil
    end
  end

  for i = 1, 5 do
    for j = 1, #Blockbuster.card_center_card_area do
      local center = Blockbuster.list_of_centers[i+(j-1)*5 + (5*#Blockbuster.card_center_card_area*(args.cycle_config.current_option - 1))]
      if not center then break end
      local card = Card(Blockbuster.card_center_card_area[j].T.x + Blockbuster.card_center_card_area[j].T.w/2, Blockbuster.card_center_card_area[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
      card.sticker = get_joker_win_sticker(center)
      Blockbuster.card_center_card_area[j]:emplace(card)
    end
  end
end
