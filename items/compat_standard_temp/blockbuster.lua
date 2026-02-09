Blockbuster.ValueManipulation.CompatStandard{
    key = "blockbuster",
    prefix_config = {key = { mod = false, atlas = false}},
    source_mod = "Blockbuster-ValueManipulation",
    variable_conventions = {
        full_vars = {
            "stacks",
            "goal",
            "chance",
            "chance_cur",
            "reset",
            "threshold",
            "time_spent",
            "codex_length"
        },
        ends_on = {
            "_non"
        },
        starts_with = {
            "base_",
            "time_",
            "stacked_",
            "rank_"
        }
    },
}
