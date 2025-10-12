Blockbuster.ValueManipulation.CompatStandard{
    key = "vanilla_base",
    prefix_config = {key = { mod = false, atlas = false}},
    source_mod = "Vanilla",
    exempt_jokers = {

        -- These jokers are exempt because their mechanics do not make sense for value manipulation
        j_stencil = true,
        j_four_fingers = true,

        j_ceremonial = true,
        j_8_ball = true,
        j_raised_fist = true,
        j_chaos = true,

        j_pareidolia = true,
        j_space = true,
        
        j_dna = true,
        j_splash = true,
        j_sixth_sense = true,
        j_superposition = true,

        j_seance = true,
        j_shortcut = true,
        j_vagabond = true,

        j_midas_mask = true,
        j_luchador = true,
        j_hallucination = true,

        j_diet_cola = true,


        j_certificate = true,
        j_smeared = true,

        j_ring_master = true,
        j_blueprint = true,
        j_merry_andy = true,
        j_oops = true,

        j_invisible = true,
        j_brainstorm = true,
        j_cartomancer = true,
        j_astronomer = true,
        j_burnt = true,
        j_chicot = true,

        -- These jokers are exempt because their vanilla code does not allow for value manipulation
        j_mr_bones = true,
        j_perkeo = true,
        j_business = true,
    },
    variable_conventions = {
        full_vars = {
            "odds",
            "size",
            "d_remaining",
            "faces",
            "h_mod",
            "discards",
            "every",
            "h_plays"
        },
        ends_on = {
        },
        starts_with = {
        }
    },
}
