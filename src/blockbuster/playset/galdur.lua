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
    local _pool = {}
    for i, v in pairs(Blockbuster.Playset.ContentPackages) do
        _pool[#_pool + 1] = v
    end

    generate_playset_card_areas()
    Galdur.include_deck_preview()

    local deck_preview = Galdur.display_deck_preview()
    deck_preview.nodes[#deck_preview.nodes+1] = {n = G.UIT.R, config={align = 'cm', padding = 0.15}, nodes = {
        {n=G.UIT.C, config = {maxw = 2.5, minw = 2.5, minh = 0.8, r = 0.1, hover = true, ref_value = 1, button = 'random_sleeve', colour = Galdur.badge_colour, align = "cm", emboss = 0.1}, nodes = {
            {n=G.UIT.R, config = {align = 'cm'}, nodes = {{n=G.UIT.T, config={text = localize("gald_random_sleeve"), scale = 0.4, colour = G.C.WHITE}}}},
            {n=G.UIT.R, config = {align = 'cm'}, nodes = {{n=G.UIT.C, config={func = 'set_button_pip', focus_args = { button = 'triggerright', set_button_pip = true, offset = {x=-0.2, y = 0.3}}}}}}
        }}
    }}

    return
    {n=G.UIT.ROOT, config={align = "tm", minh = 3.8, colour = G.C.CLEAR, padding=0.1}, nodes={
        {n=G.UIT.C, config = {padding = 0.15}, nodes ={
            generate_playset_card_areas_ui(_pool),
            create_playset_page_cycle(_pool),
        }},
        deck_preview
    }}
end

-- Playset information Screen
function Blockbuster.Playset.include_playset_preview(animate)
    generate_playset_card_areas()
    Galdur.generate_deck_preview()
    Galdur.populate_deck_preview(Galdur.run_setup.choices.deck, not animate)
end

function Galdur.generate_deck_preview()
    if Galdur.run_setup.selected_deck_area then
        for j=1, #G.I.CARDAREA do
            if Galdur.run_setup.selected_deck_area == G.I.CARDAREA[j] then
                table.remove(G.I.CARDAREA, j)
                Galdur.run_setup.selected_deck_area = nil
            end
        end
    end

    Galdur.run_setup.selected_deck_area = CardArea(15.475, 0, G.CARD_W, G.CARD_H, 
    {card_limit = 52, type = 'deck', highlight_limit = 0, deck_height = 0.15, thin_draw = 1, selected_deck = true})
    Galdur.run_setup.selected_deck_area_holding = CardArea(Galdur.run_setup.selected_deck_area.T.x+2*G.CARD_W, -2*G.CARD_H, G.CARD_W, G.CARD_H, 
    {card_limit = 52, type = 'deck', highlight_limit = 0, deck_height = 0.15, thin_draw = 1, selected_deck = true})
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
        {card_limit = 5, type = 'display', highlight_limit = 0, deck_height = 0.35, thin_draw = 1, index = i})
    end
end

function generate_playset_card_areas_ui(pool)

    local deck_ui_element = {}
    local count = 1
    
    for i=1, 2 do
        local row = {n = G.UIT.R, config = {colour = G.C.LIGHT}, nodes = {}}
        for j=1, 6 do
            if count > #pool then return end
            table.insert(row.nodes, {n = G.UIT.O, config = {object = Galdur.run_setup.deck_select_areas[count], r = 0.1, id = "deck_select_"..count, focus_args = { snap_to = true },}})
            count = count + 1
        end
        table.insert(deck_ui_element, row)
    end
    populate_playset_card_areas(1, pool)
    return {n=G.UIT.R, config={align = "cm", minh = 3.3, minw = 5, colour = G.C.BLACK, padding = 0.15, r = 0.1, emboss = 0.05}, nodes=deck_ui_element}
end

function create_playset_page_cycle(pool)
    local options = {}
    local cycle
    if #pool > 12 then
        local total_pages = math.ceil(#pool / 12)
        for i=1, total_pages do
            table.insert(options, localize('k_page')..' '..i..' / '..total_pages)
        end
        cycle = create_option_cycle({
            options = options,
            w = 4.5,
            opt_callback = 'change_deck_page',
            focus_args = { snap_to = true, nav = 'wide' },
            current_option = 1,
            colour = G.C.RED,
            no_pips = true
        })
    end
    return {n = G.UIT.R, config = {align = "cm"}, nodes = {cycle}}
end

function populate_playset_card_areas(page, pool)
    local count = 1 + (page - 1) * 12
    for i=1, 12 do
        if count > #pool then return end
        local card_number = Galdur.config.reduce and 1 or 10
        for index = 1, card_number do
            local card = Card(Galdur.run_setup.deck_select_areas[i].T.x,Galdur.run_setup.deck_select_areas[i].T.y, G.CARD_W, G.CARD_H, pool[count], pool[count],
                {galdur_back = Back(pool[count]), deck_select = i})
            card.sprite_facing = 'front'
            card.facing = 'front'
            card.children.front:remove()
            card.children.front = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[pool[count].unlocked and pool[count].atlas or 'centers'], pool[count].unlocked and pool[count].pos or {x = 4, y = 0})
            card.children.front.states.hover = card.states.hover
            card.children.front.states.click = card.states.click
            card.children.front.states.drag = card.states.drag
            card.children.front.states.collide.can = false
            card.children.front:set_role({major = card, role_type = 'Glued', draw_major = card})
            if not Galdur.run_setup.deck_select_areas[i].cards then Galdur.run_setup.deck_select_areas[i].cards = {} end
            Galdur.run_setup.deck_select_areas[i]:emplace(card)
            if index == card_number then
                card.deck_select_position = {page = page, count = i}
            end
        end
        count = count + 1
    end
end

Galdur.add_new_page({
    definition = Blockbuster.kino_galdur_select_playset,
    name = 'kino_select_playset',
    quick_start_text = function() return localize({type='name_text', set='Stake', key=G.P_CENTER_POOLS.Stake[Galdur.run_setup.choices.stake].key}) end
})













end