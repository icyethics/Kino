SMODS.Keybind({
    key_pressed = "k",
    held_keys = { "space" },
    action = function(self)
        print("pressed")
        local selected = G and G.CONTROLLER and
            (G.CONTROLLER.focused.target or G.CONTROLLER.hovering.target)

        if not selected then
            return
        end
        G.SETTINGS.paused = true
        G.FUNCS.overlay_menu{
            definition = Kino.create_overlay_joker_showcase(selected),
        }
        
    end
})

function Kino.create_overlay_joker_showcase(source_joker)

    local _castlist = nil
    if source_joker and source_joker.config and source_joker.config.center and
    source_joker.config.center.kino_joker then
        _castlist = create_cast_list_for_specific_jokers(source_joker)
    else
        _castlist = create_cast_list()
    end

    Kino.list_of_centers = {}
    for _index, _center in ipairs(G.P_CENTER_POOLS["Joker"]) do
        if has_cast_from_table(_center, _castlist) then
            Kino.list_of_centers[#Kino.list_of_centers + 1] = _center
            print(_index)
        end
    end

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

    local joker_options = {}
    for i = 1, math.ceil(#Kino.list_of_centers/(5*#Kino.actor_collection)) do
        table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#Kino.list_of_centers/(5*#Kino.actor_collection))))
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
    
    local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
            {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
            {n=G.UIT.R, config={align = "cm"}, nodes={
            create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'kino_actor_matching_joker_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
            }}
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
