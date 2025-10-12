Blockbuster.compat_categories = {
    blueprint_compat = {value = "blueprint_compat", default = true, colour = G.C.BLUE},
    retrigger_compat = {value = "retrigger_compat", default = true, colour = G.C.PURPLE},
    bb_valuemanip_compat = {value = "bb_valuemanip_compat", default = false, colour = G.C.GREEN},
}

local generate_ui_ref = SMODS.Center.generate_ui
function SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    local full_UI_table = generate_ui_ref(self, ...)

    local _list_of_compat_nodes = {}
    for _key, _item in pairs(Blockbuster.compat_categories) do
        local _colour = G.C.BLACK

        if _item.default == true then
            _colour = _item.colour
            if card.config.center[_item.value] and card.config.center[_item.value] == false then
                _colour = G.C.BLACK
            end

        else
            _colour = G.C.BLACK
            if card.config.center[_item.value] and card.config.center[_item.value] == false then
                _colour = _item.colour
            end
        end


        local _node = {
            n = G.UIT.C,
            config = {
                align = "cm",
                minw = 0.1,
                minh = 0.1,
                maxw = 0.1,
                maxh = 0.1,
                colour = _colour,
                r = 1,
            },
            
        }

        _list_of_compat_nodes[#_list_of_compat_nodes + 1] = _node
    end

    full_UI_table.name = {
        {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.05 },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = full_UI_table.name
                },
                {
                    n = G.UIT.R,
                    config = { align = 'cm'},
                    nodes = _list_of_compat_nodes
                }

            }
        }
    }
end