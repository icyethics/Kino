SMODS.Keybind({
    key_pressed = "k",
    action = function(self)
        local selected = G and G.CONTROLLER and
            (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end
        if selected and selected.config and selected.config.center and
        selected.config.center.kino_joker then
            G.SETTINGS.paused = true
            G.FUNCS.overlay_menu{
                definition = Kino.create_overlay_joker_showcase(selected),
            }
        end
        
    end
})

function Kino.create_overlay_joker_showcase(source_joker)

    local _castlist = nil
    if source_joker and source_joker.config and source_joker.config.center and
    source_joker.config.center.kino_joker then
        _castlist = create_cast_list_for_specific_jokers(source_joker)
    else
        -- TEMPORARILY DISABLED
        -- _castlist = create_cast_list()
        return nil
    end

    Kino.list_of_centers = {}
    Kino.showcase_actor_center = nil
    for _index, _center in ipairs(G.P_CENTER_POOLS["Joker"]) do
        if _center == source_joker.config.center then
            Kino.showcase_actor_center = _center
        elseif has_cast_from_table(_center, _castlist) then
            Kino.list_of_centers[#Kino.list_of_centers + 1] = _center
        end
    end

    -- matching jokers for right view
    local deck_tables = {}
    Kino.actor_collection = {}
    for j = 1, 3 do
        Kino.actor_collection[j] = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        5*G.CARD_W,
        0.95*G.CARD_H, 
        {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
        table.insert(deck_tables, 
            {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
            {n=G.UIT.O, config={object = Kino.actor_collection[j]}}
            }}
        )
    end

    -- Showcase joker for left view
    local showcase_jokers = {}
    Kino.showcase_joker = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        1*G.CARD_W,
        0.95*G.CARD_H, 
        {card_limit = 1, type = 'title', highlight_limit = 0, collection = true}
    )
    table.insert(showcase_jokers, 
        {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
        {n=G.UIT.O, config={object =  Kino.showcase_joker}}
        }}
    )
    local showcase_card = Card(Kino.showcase_joker.T.x + Kino.showcase_joker.T.w/2, Kino.showcase_joker.T.y, G.CARD_W, G.CARD_H, nil, Kino.showcase_actor_center)
    Kino.showcase_joker:emplace(showcase_card)


    local joker_options = {}
    for i = 1, math.ceil(#Kino.list_of_centers/(5*#Kino.actor_collection)) do
        table.insert(joker_options, localize('k_kino_shared_cast')..' '..tostring(i)..'/'..tostring(math.ceil(#Kino.list_of_centers/(5*#Kino.actor_collection))))
    end

    for i = 1, 5 do
        for j = 1, #Kino.actor_collection do
            local center = Kino.list_of_centers[i+(j-1)*5]
            if not center then break end
            local card = Card(Kino.actor_collection[j].T.x + Kino.actor_collection[j].T.w/2, Kino.actor_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
            card.sticker = get_joker_win_sticker(center)
            Kino.actor_collection[j]:emplace(card)
        end
    end

    local _metadata_nodes = {}
    local _metadata_table = source_joker.config.center.kino_joker
    local _metadata_entries = {"directors", "budget", "box_office", "release_date", "cast"}
    local _metadata_strings = {localize('k_kino_directed_by'), localize('k_kino_budget'), localize('k_kino_box_office'), localize('k_kino_release_date'), localize('k_kino_shared_cast_list')}
    for _, _key in ipairs(_metadata_entries) do
        local _text = ""

        if _key == "directors" then
            local _directors = {}
            if type(_metadata_table[_key]) ~= "table" then
                _directors[1] = _metadata_table[_key]
            else
                _directors = _metadata_table[_key]
            end
            for _, _entry in ipairs(_directors) do

                if _entry then
                    _text = _text .. Kino.actors[_entry].name
                    if _ ~= #_directors then
                        _text = _text .. " & "
                    end
                else
                   _text = "Alan Smithee?" 
                end
            end
        end

        if _key == "budget" or _key == "box_office" then
            local _value = _metadata_table[_key]
            local _val_as_string = tostring(_value)

            if _value > 999999999 then
                local _start, _garb = string.sub(_value, 1, -10)
                _text = "$" .. _start .. " Billion"    
            elseif _value > 999999 then
                local _start, _garb = string.sub(_value, 1, -7)
                _text = "$" .. _start .. " Million"  
            elseif _value > 999 then
                local _start, _garb = string.sub(_value, 1, -4)
                _text = "$" .. _start .. " Thousand"  
            end
        end

        if _key == "release_date" then
            local _value = _metadata_table[_key]
            _text = _value
            -- local _year = tonumber(string.sub(_joker.release_date, 1, 4))
            -- local _month = tonumber(string.sub(_joker.release_date, 6, 7))
            -- local _day = tonumber(string.sub(_joker.release_date, 9, 10))
        end

        if _key == "cast" then
            _text = tostring(#Kino.list_of_centers)
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
                        text = _metadata_strings[_] .. _text
                        -- text = "Truly just a test text"
                    }
                }
            }
        }
        table.insert(_metadata_nodes, _node)

    end
    
    local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
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
                                            text = "Current Joker",
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

  for j = 1, #Kino.actor_collection do
    for i = #Kino.actor_collection[j].cards,1, -1 do
      local c = Kino.actor_collection[j]:remove_card(Kino.actor_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end

  for i = 1, 5 do
    for j = 1, #Kino.actor_collection do
      local center = Kino.list_of_centers[i+(j-1)*5 + (5*#Kino.actor_collection*(args.cycle_config.current_option - 1))]
      if not center then break end
      local card = Card(Kino.actor_collection[j].T.x + Kino.actor_collection[j].T.w/2, Kino.actor_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
      card.sticker = get_joker_win_sticker(center)
      Kino.actor_collection[j]:emplace(card)
    end
  end
end
