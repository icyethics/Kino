function create_UIBox_counters()
    return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Counter, {5,5}, {
        snap_back = true,
        infotip = localize('bb_counter_tooltip'),
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.03,
        modify_card = function(card, center)
            card:bb_counter_apply(center, 1)
        end,
    })
end

SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
            button = 'your_collection_counters', 
            label = {'Counters'}, 
            minw = 5,
            minh = 1, 
            id = 'your_collection_counters', 
            focus_args = {snap_to = true}
        })
    }
end

G.FUNCS.your_collection_counters = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_counters(),
    }
end