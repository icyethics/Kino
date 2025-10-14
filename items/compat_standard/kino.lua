Blockbuster.ValueManipulation.CompatStandard{
    key = "kino",
    source_mod = "kino",
    variable_conventions = {
        full_vars = {
            "stacks",
            "goal",
            "chance",
            "chance_cur",
            "reset",
            "threshold",
            "time_spent",
            "codex_length",
            "num_cards_abducted",
            "starting_amount"
        },
        ends_on = {
            "_non"
        },
        starts_with = {
            "base_",
            "time_",
            "stacked_",
            "rank_",
        }
    },
    integer_only_variable_conventions = {
        full_vars = {
            "cards_created",
            "retriggers",
            "repetitions",
            "joker_slots",
            "handsize",
            "display_amount"
        },
        ends_on = {
            "_int",
            "_slots"
        },
        starts_with = {
        },
    },
    variable_caps = {
        cards_created = 25,
        retriggers = 25, 
        repetitions = 25,
        joker_slots = 25,
        handsize = 25,
        display_amount = 10,
    },
    exempt_jokers = {
        -- Non compatible designs
        j_kino_12_monkeys = true,
        j_kino_alien_3 = true,
        j_kino_anora = true,
        j_kino_apollo_13 = true,
        j_kino_asteroid_city = true,

        j_kino_benjamin_button = true,
        j_kino_big_daddy = true,
        j_kino_blade_runner = true,
        j_kino_blair_witch = true,
        j_kino_bloodshot = true,

        -- 10
        -- j_kino_bttf = true,
        j_kino_blank_check = true,
        j_kino_bucket_list = true,
        j_kino_charlie_and_the_chocolate_factory = true,
        j_kino_chef = true,
        j_kino_childs_play_1 = true,

        j_kino_contagion = true,
        j_kino_cruella = true,
        j_kino_da_5_bloods = true,
        j_kino_death_race = true,
        j_kino_doctor_strange_1 = true,

        -- 20
        j_kino_doctor_strange_2 = true,
        j_kino_doctor_who = true,
        j_kino_edward_scissorhands = true,
        j_kino_encanto = true,
        j_kino_fantasia = true,

        j_kino_founder = true,
        j_kino_freaky_friday_3 = true,
        j_kino_friday_the_13th = true,
        j_kino_ghoulies = true,
        j_kino_grown_ups_1 = true,

        -- 30
        j_kino_guardians_of_the_galaxy_2 = true,
        j_kino_guardians_of_the_galaxy_3 = true,
        j_kino_harry_potter_1 = true,
        j_kino_her = true,
        j_kino_hook = true,

        j_kino_inception = true,
        j_kino_insomnia = true,
        j_kino_interstellar = true,
        j_kino_iron_man_1 = true,
        j_kino_junior = true,

        -- 40
        j_kino_karate_kid_1 = true,
        j_kino_la_la_land = true,
        j_kino_menu = true,
        j_kino_minecraft = true,
        j_kino_moneyball = true,

        j_kino_oceans_11 = true,
        j_kino_oceans_11_2 = true,
        j_kino_oppenheimer = true,
        j_kino_pain_and_gain = true,
        j_kino_pirates_movie = true,

        -- 50
        j_kino_resident_evil = true,
        j_kino_rocky_1 = true,
        j_kino_rogue_one = true,
        j_kino_school_of_rock = true,
        j_kino_shang_chi = true,
        
        j_kino_shazam_1 = true,
        j_kino_sleepy_hollow = true,
        j_kino_smile = true,
        j_kino_solo = true,
        j_kino_sorcerers_apprentice = true,

        -- 60
        j_kino_stand_by_me = true,
        j_kino_terminator_1 = true,
        j_kino_thing = true,
        j_kino_your_highness = true,
        j_kino_2001_odyssey = true,
    },
}
