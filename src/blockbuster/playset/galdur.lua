-- Based on the Galdur page code in the CardSleeves mod and Galdur's own code

-- if Galdur and NONETHISSHOULDNTRUNYET then
if Galdur then

-- #region GLOBALS (Will probably rewrite this to not use this this way, but it's currently how CS has it set up)

local playset_card_areas = {}
local playset_count_horizontal = 6
local playset_count_vertical = 2
local playset_page_count = playset_count_horizontal * playset_count_vertical

local galdur_page_index = 5 -- Should be after stake

--#endregion
function Blockbuster.kino_galdur_select_playset()
    Blockbuster.Playset.startup.contentPackages = {}
    Blockbuster.Playset.run_setup = {}
    Blockbuster.Playset.run_setup.pool = {}
    Blockbuster.Playset.run_setup.playset_pool = {}
    for i, v in pairs(Blockbuster.Playset.ContentPackages) do
        Blockbuster.Playset.run_setup.pool[#Blockbuster.Playset.run_setup.pool + 1] = v
    end
    for i, v in pairs(Blockbuster.Playset.Playsets) do
        Blockbuster.Playset.run_setup.playset_pool[#Blockbuster.Playset.run_setup.playset_pool + 1] = v
    end

    Blockbuster.Playset.startup.choices = {
        playset = Blockbuster.Playset.Playsets["kino_standardsize_movies"]
    }
    

    generate_playset_card_areas()
    Blockbuster.Playset.include_playset_preview()

    local playset_preview = Blockbuster.Playset.display_playset_preview()
    playset_preview.nodes[#playset_preview.nodes+1] = 
        {n = G.UIT.R, config={align = 'cm', padding = 0.15}, nodes = {
            create_playset_preview_page_cycle()
        }}

    return
    {n=G.UIT.ROOT, config={align = "tm", minh = 3.8, colour = G.C.CLEAR, padding=0.1}, nodes={
        {n=G.UIT.C, config = {padding = 0.15}, nodes ={
            generate_playset_card_areas_ui(),
            create_playset_page_cycle(),
        }},
        playset_preview
    }}
end

-- Playset information Screen
function Blockbuster.Playset.include_playset_preview(animate)
    generate_playset_card_areas()
    Blockbuster.Playset.playset_preview()
    Blockbuster.Playset.populate_deck_preview(1)
end

function Blockbuster.Playset.playset_preview()
    if Blockbuster.Playset.run_setup.selected_playset_area then
        for j=1, #G.I.CARDAREA do
            if Blockbuster.Playset.run_setup.selected_playset_area == G.I.CARDAREA[j] then
                table.remove(G.I.CARDAREA, j)
                Blockbuster.Playset.run_setup.selected_playset_area = nil
            end
        end
    end
    Blockbuster.Playset.run_setup.selected_playset_area = CardArea(15.475, 0, G.CARD_W, G.CARD_H, 
    {card_limit = 1, type = 'title', highlight_limit = 0, deck_height = 0.15, thin_draw = 1})
    Blockbuster.Playset.run_setup.selected_playset_area_holding = CardArea(Blockbuster.Playset.run_setup.selected_playset_area.T.x+2*G.CARD_W, -2*G.CARD_H, G.CARD_W, G.CARD_H, 
    {card_limit = 1, type = 'title', highlight_limit = 0, deck_height = 0.15, thin_draw = 1})
end

-- Content Packages selection screen
function generate_playset_card_areas()
    if playset_card_areas then
        for i=1, #playset_card_areas do
            for j=1, #G.I.CARDAREA do
                if playset_card_areas[i] == G.I.CARDAREA[j] then
                    table.remove(G.I.CARDAREA, j)
                    playset_card_areas[i] = nil
                end
            end
        end
    end
    playset_card_areas = {}
    for i=1, playset_page_count do
        playset_card_areas[i] = CardArea(G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h, 0.95*G.CARD_W, 0.945*G.CARD_H,
        {card_limit = 1, type = 'title', highlight_limit = 0, deck_height = 0.35, thin_draw = 1, index = i})
    end
end

function generate_playset_card_areas_ui()

    local deck_ui_element = {}
    local count = 1
    
    for i=1, 2 do
        local row = {n = G.UIT.R, config = {colour = G.C.LIGHT}, nodes = {}}
        for j=1, 6 do
            if count > #Blockbuster.Playset.run_setup.pool then return end
            table.insert(row.nodes, {n = G.UIT.O, config = {object = playset_card_areas[count], r = 0.1, id = "content_package_select_"..count, focus_args = { snap_to = true },}})
            count = count + 1
        end
        table.insert(deck_ui_element, row)
    end
    populate_playset_card_areas(1)
    return {n=G.UIT.R, config={align = "cm", minh = 3.3, minw = 5, colour = G.C.BLACK, padding = 0.15, r = 0.1, emboss = 0.05}, nodes=deck_ui_element}
end

function create_playset_page_cycle()
    local options = {}
    local cycle
    if #Blockbuster.Playset.run_setup.pool > 12 then
        local total_pages = math.ceil(#Blockbuster.Playset.run_setup.pool / 12)
        for i=1, total_pages do
            table.insert(options, localize('k_page')..' '..i..' / '..total_pages)
        end
        cycle = create_option_cycle({
            options = options,
            w = 4.5,
            opt_callback = 'change_content_package_page',
            focus_args = { snap_to = true, nav = 'wide' },
            current_option = 1,
            colour = G.C.RED,
            no_pips = true
        })
    end
    return {n = G.UIT.R, config = {align = "cm"}, nodes = {cycle}}
end

function create_playset_preview_page_cycle()
    local options = {}
    local cycle
    if #Blockbuster.Playset.run_setup.playset_pool > 1 then
        local total_pages = math.ceil(#Blockbuster.Playset.run_setup.playset_pool)
        for i=1, total_pages do
            table.insert(options, i..' / '..total_pages)
        end
        cycle = create_option_cycle({
            options = options,
            w = 1.5,
            opt_callback = 'change_playset_page',
            focus_args = { snap_to = true, nav = 'wide' },
            current_option = 1,
            colour = G.C.RED,
            no_pips = true
        })
    end
    return {n = G.UIT.R, config = {align = "cm"}, nodes = {cycle}}
end

G.FUNCS.change_content_package_page = function(args)
    Blockbuster.Playset.clean_deck_areas()
    populate_playset_card_areas(args.cycle_config.current_option)
end

G.FUNCS.change_playset_page = function(args)
    Blockbuster.Playset.clean_deck_areas(true)
    populate_playset_card_areas(1)
    Blockbuster.Playset.populate_deck_preview(args.cycle_config.current_option)
end

function Blockbuster.Playset.clean_deck_areas(deep_clean)
    if not playset_card_areas then return end
    for j = #playset_card_areas, 1, -1 do
        if playset_card_areas[j].cards then
            remove_all(playset_card_areas[j].cards)
            playset_card_areas[j].cards = {}
        end
    end

    if deep_clean then
        Blockbuster.Playset.startup.contentPackages = {}
        
    end
end

function populate_playset_card_areas(page)
    local count = 1 + (page - 1) * 12
    for i=1, 12 do
        if count > #Blockbuster.Playset.run_setup.pool then return end
        local card_number = Galdur.config.reduce and 1 or 10
        local card = Card(playset_card_areas[i].T.x,playset_card_areas[i].T.y, G.CARD_W, G.CARD_H, nil, Blockbuster.Playset.run_setup.pool[count])
        card.during_galdur = true
        card.sprite_facing = 'front'
        if not playset_card_areas[i].cards then playset_card_areas[i].cards = {} end
        playset_card_areas[i]:emplace(card)
        -- end
        count = count + 1
    end
end

Galdur.add_new_page({
    definition = Blockbuster.kino_galdur_select_playset,
    name = 'kino_select_playset',
    quick_start_text = function() return localize({type='name_text', set='Stake', key=G.P_CENTER_POOLS.Stake[Galdur.run_setup.choices.stake].key}) end
})

end

function Blockbuster.Playset.display_playset_preview()
    -- print(Blockbuster.Playset.startup.choices.playset)
    
    local texts = split_string_2(Blockbuster.Playset.startup.choices.playset:get_name())
    -- prints(texts)
    Blockbuster.Playset.preview_texts = {
        name_1 = texts[1],
        name_2 = texts[2]
    }

    local deck_node = {n=G.UIT.R, config={align = "tm"}, nodes={
        {n = G.UIT.O, config = {object = Blockbuster.Playset.run_setup.selected_playset_area}}
    }}

    return 
    {n=G.UIT.C, config = {align = "tm", padding = 0.15}, nodes ={
        {n = G.UIT.R, config = {minh = 5.95, minw = 3, maxw = 3, colour = G.C.BLACK, r=0.1, align = "bm", padding = 0.15, emboss=0.05}, nodes = {
            {n = G.UIT.R, config = {align = "cm", minh = 0.6, maxw = 2.8}, nodes = {
                {n=G.UIT.O, config = {id = 'name_1', object = DynaText({
                    string = {{ref_table = Blockbuster.Playset.preview_texts, ref_value = 'name_1'}},
                    scale = 0.7/math.max(1, string.len(Blockbuster.Playset.preview_texts.name_1)/8),
                    colours = {G.C.GREY},
                    pop_in_rate = 5,
                    silent = true
                })}}
            }},
            {n = G.UIT.R, config = {align = "cm", minh = 0.6, maxw = 2.8}, nodes = {
                {n=G.UIT.O, config = {id = 'name_2', object = DynaText({
                    string = {{ref_table = Blockbuster.Playset.preview_texts, ref_value = 'name_2'}},
                    scale = 0.7/math.max(1, string.len(Blockbuster.Playset.preview_texts.name_2)/8),
                    colours = {G.C.GREY},
                    pop_in_rate = 5,
                    silent = true
                })}}
            }},
            {n = G.UIT.R, config = {align = "cm", minh = 0.2}},
                deck_node,
            {n = G.UIT.R, config = {minh = 0.8, align = 'bm'}, nodes = {
                {n = G.UIT.T, config = {text = localize('gald_selected'), scale = 0.75, colour = G.C.GREY}}
            }},
        }}
    }}
end

function Blockbuster.Playset.populate_deck_preview(page)
    local count = 1 + (page - 1)
    if Blockbuster.Playset.run_setup.selected_playset_area.cards then
        remove_all(Blockbuster.Playset.run_setup.selected_playset_area.cards)
        Blockbuster.Playset.run_setup.selected_playset_area.cards = {}
        remove_all(Blockbuster.Playset.run_setup.selected_playset_area_holding.cards)
        Blockbuster.Playset.run_setup.selected_playset_area_holding.cards = {} 
    end

    Blockbuster.Playset.startup.choices.playset = Blockbuster.Playset.run_setup.playset_pool[count]

    local card = Card(Blockbuster.Playset.run_setup.selected_playset_area.T.x+2*G.CARD_W, -2*G.CARD_H, G.CARD_W, G.CARD_H,
        nil, Blockbuster.Playset.run_setup.playset_pool[count])
    card.during_galdur = true
    card.sprite_facing = 'front'
    
    Blockbuster.Playset.run_setup.selected_playset_area:emplace(card)
end

function Blockbuster.Playset.playset_content_package_preblock()

end