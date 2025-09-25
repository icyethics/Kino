function create_UIBox_spells()
    local _pool = {}
    for i, v in pairs(Blockbuster.Spellcasting.Spells) do
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
