
local o_calccon = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    local ret = o_calccon(context, return_table)

    -- add G.hand card area
    local flags = {}
end