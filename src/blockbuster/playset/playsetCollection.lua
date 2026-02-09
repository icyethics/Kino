function create_UIBox_content_packages()
    local _pool = {}
    for i, v in pairs(Blockbuster.Playset.ContentPackages) do
        _pool[i] = v
    end

    return SMODS.card_collection_UIBox(_pool, { 5, 5 }, {
        snap_back = true,
        hide_single_page = true,
        collapse_single_page = true,
        -- center = 'c_base',
        h_mod = 1.03,
        back_func = 'your_collection_other_gameobjects',
        no_materialize = true, 
        modify_card = function(card, center)
            card.ignore_pinned = true
            -- center:apply(card, true)
        end,
    })
end

function create_UIBox_playsets()
    local _pool = {}
    for i, v in pairs(Blockbuster.Playset.Playsets) do
        print(i)
        _pool[i] = v
    end
    

    return SMODS.card_collection_UIBox(_pool, { 5, 5 }, {
        snap_back = true,
        hide_single_page = true,
        collapse_single_page = true,
        -- center = 'c_base',
        h_mod = 1.03,
        back_func = 'your_collection_other_gameobjects',
        no_materialize = true, 
        modify_card = function(card, center)
            card.ignore_pinned = true
            -- center:apply(card, true)
        end,
    })
end

SMODS.current_mod.custom_collection_tabs = function()
    return Blockbuster.Playset.CollectionTab()
end

Blockbuster.Playset.CollectionTab = function()
    return {
        UIBox_button({
            button = 'your_collection_content_packages', 
            label = {'Content Packages'}, 
            minw = 5,
            minh = 1, 
            id = 'your_collection_content_packages', 
            focus_args = {snap_to = true}
        })
    }
end

Blockbuster.Playset.CollectionTab_Playset = function()
    return {
        UIBox_button({
            button = 'your_collection_playsets', 
            label = {'Playsets'}, 
            minw = 5,
            minh = 1, 
            id = 'your_collection_playsets', 
            focus_args = {snap_to = true}
        })
    }
end

G.FUNCS.your_collection_content_packages = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_content_packages(),
    }
end

G.FUNCS.your_collection_playsets = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_playsets(),
    }
end

