-- Size classifications:
-- Small <150 Jokers, < 8 enhancements
-- Standard ~150 jokers, 8 enhancements
-- Large ~200 jokers, 10 enhancements
-- Huge ~250 jokers, 12 enhancements
-- Giant ~300 jokers, 14 enhancements
-- Giant+ > 300 jokers, > 14 enhancements



-- Classic Kino
Blockbuster.Playset.Playset {
    key = "standardsize_movies",
    name = "standardsize_movies",
    types = {"Standard","Aesthetic"},
    sets = {"Joker"},
    packages = {
        standard_kino_playset = true, -- 149
        all_kino_enhancements = true, -- 15
        all_kino_consumables = true, -- 
        -- all_kino_tarot = true,
        -- all_kino_tags = true,
        all_kino_vouchers = true,

        -- vanilla content
        vanilla_kino_tarots = true,
        -- all_vanilla_tags = true,
        all_vanilla_vouchers = true,
        all_vanilla_planets = true,
        all_vanilla_spectrals = true,
    },
    mods = {
        "Vanilla",
        "kino"
    }
}

Blockbuster.Playset.ContentPackage {
    key = "vanilla_kino_tarots",
    name = "Vanilla-Kino tarots",
    prefix_config = {key = { mod = false, atlas = false}},
    displayImage = 'c_high_priestess',
    types = {"Standard", "Full"},
    sets = {"Tarot"},
    items = {
        -- Jokers
        -- Jokers: Commons

        -- TAROTS
        -- Tarots: Vanilla
        c_fool = true,
        c_high_priestess = true,
        c_strength = true,
        c_hanged_man = true,
        c_death = true,
        c_star = true,
        c_moon = true,
        c_sun = true,
        c_judgement = true,
        c_world = true,
    },
    mods = {
        'Vanilla'
    }
}


Blockbuster.Playset.ContentPackage {
    key = "standard_kino_playset",
    name = "Standard Kino Jokers",
    prefix_config = {key = { mod = false, atlas = false}},
    displayImage = 'j_kino_clown',
    types = {"Standard", "Full"},
    sets = {"Joker"},
    items = {
        -- Jokers
        -- Jokers: Commons
        j_kino_clown = true,
        j_kino_big_short = true,
        j_kino_braveheart = true,
        j_kino_megalopolis = true,
        j_kino_pink_panther_1 = true,
        j_kino_secretary = true,
        j_kino_skyscraper = true,
        j_kino_lethal_weapon = true,
        j_kino_double = true,
        j_kino_three_musketeers_1 = true,
        j_kino_monster_house = true,
        j_kino_breakfast_club = true,
        j_kino_dickie_roberts = true,
        j_kino_gentlemen_prefer_blondes = true,
        j_kino_titanic = true,
        j_kino_captain_blood = true,
        j_kino_cocktail = true,
        j_kino_double_dragon = true,
        j_kino_ed_wood = true,
        j_kino_easy_a = true,
        j_kino_encanto = true,
        j_kino_elf = true,
        j_kino_elephant_man = true,
        j_kino_alien_3 = true,
        j_kino_grown_ups_1 = true,
        j_kino_guardians_of_the_galaxy_1 = true,
        j_kino_gullivers_travels = true,
        j_kino_heart_eyes = true,
        j_kino_i_robot = true,
        j_kino_iron_lady = true,
        j_kino_kindergarten_cop = true,
        j_kino_mafiamamma = true,
        j_kino_meet_the_parents = true,
        j_kino_mr_and_mrs_smith = true,
        j_kino_my_neighbor_totoro =true,
        j_kino_nope = true,
        j_kino_paulblart_1 = true,
        j_kino_panic_room = true,
        j_kino_pinocchio_2022 = true,
        j_kino_psycho = true,
        j_kino_superman_2025 = true,
        j_kino_thor_1 = true,
        j_kino_ready_player_one = true,
        j_kino_ringu = true,
        j_kino_rocky_1 = true,
        j_kino_sleepy_hollow = true,
        j_kino_social_network = true,
        j_kino_spartacus = true,
        j_kino_snowpiercer = true,
        j_kino_star_wars_v = true,
        j_kino_sugarland_express = true,
        j_kino_tree_of_life = true,
        j_kino_twins = true,
        j_kino_up = true,
        j_kino_voyage_dans_le_lune = true,
        j_kino_what_we_do_in_the_shadows = true,
        j_kino_wonka = true,
        j_kino_x = true,
        j_kino_pirates_of_the_caribbean_3 = true,
        j_kino_ghostbusters_1 = true,
        j_kino_avatar = true,
        j_kino_war_of_the_worlds_2025 = true,

        -- Uncommon
        j_kino_500_days_of_summer = true,
        j_kino_30_days_of_night = true,
        j_kino_50_first_dates = true,

        j_kino_abyss = true,
        j_kino_alien_1 = true,
        j_kino_apollo_13 = true,
        j_kino_blue_velvet = true,
        j_kino_castaway = true,
        j_kino_chef = true,
        j_kino_close_encounters = true,
        j_kino_die_hard_1 = true,
        j_kino_dinner_with_andre = true,
        j_kino_dead_zone = true,

        j_kino_creature_from_the_black_lagoon = true,
        j_kino_cruella = true,
        j_kino_doctor_who = true,
        j_kino_edward_scissorhands = true,
        j_kino_fargo = true,
        j_kino_ghoulies = true,
        j_kino_gone_girl = true,
        j_kino_goodfellas = true,
        j_kino_gravity = true,
        j_kino_guardians_of_the_galaxy_2 = true,

        j_kino_her = true,
        j_kino_hot_fuzz = true,
        j_kino_independence_day_1 = true,
        j_kino_insomnia = true,
        j_kino_iron_man_1 = true,
        j_kino_joker = true,
        j_kino_junior = true,
        j_kino_kramervskramer = true,
        j_kino_mars_attacks = true,
        j_kino_marty = true,

        j_kino_men_in_black_1 = true,
        j_kino_modern_times = true,
        j_kino_moneyball = true,
        j_kino_moonfall = true,
        j_kino_muppets_treasure_island = true,
        j_kino_nightmare_on_elm_street = true,
        j_kino_oceans_11_2 = true,
        j_kino_polar_express = true,
        j_kino_pulp_fiction = true,
        j_kino_robocop_1 = true,

        j_kino_rogue_one = true,
        j_kino_se7en = true,
        j_kino_6_underground = true,
        j_kino_snow_white_1 = true,
        j_kino_sound_of_music = true,
        j_kino_star_wars_vi = true,
        j_kino_tmnt_1 = true,
        j_kino_thing = true,
        j_kino_stranger_than_fiction = true,
        j_kino_trading_places = true,

        j_kino_treasure_planet = true,
        j_kino_treasure_island = true,
        j_kino_weapons = true,
        j_kino_west_side_story_1 = true,
        j_kino_yes_man = true,
        j_kino_wicker_man = true,
        j_kino_wall_street = true,
        j_kino_v_for_vendetta = true,
        j_kino_predator = true,
        j_kino_omen = true,
        j_kino_beetlejuice_1988 = true,
        j_kino_jaws = true,

        -- Rare jokers
        j_kino_angel_hearts = true,
    
        j_kino_blair_witch = true,
        j_kino_dracula_1931 = true,
        j_kino_eternal_sunshine_of_the_spotless_mind = true,
        j_kino_fight_club = true,
        j_kino_founder = true,
        j_kino_inception = true,
        j_kino_lord_of_the_rings_1 = true,
        j_kino_oceans_11 = true,
        j_kino_muppets_2 = true,
        j_kino_party_people = true,
        j_kino_ponyo = true,
        j_kino_popeye = true,
        j_kino_shopaholic = true,
        j_kino_star_wars_viii = true,
        j_kino_pain_and_gain = true,
        j_kino_shawshank_redemption = true,
        j_kino_joe_dirt = true,
        j_kino_memento = true,

        -- Legendary
        j_kino_citizen_kane = true,
        j_kino_indiana_jones_1 = true,
        j_kino_ratatouille = true,
        j_kino_barbie = true,


    },
    mods = {
        'Kino'
    }
}

