-- The kino science pack should include jokers and enhancements that focus on
-- A space and science theme. 

Blockbuster.Playset.Playset {
    key = "science_pack",
    name = "Science & Machines",
    types = {"Large","Aesthetic"},
    sets = {"Joker", "Enhanced", "Tarot", "Spectral", "Voucher", "Booster"},
    packages = {
        -- 200~ jokers
        -- 10~ enhancements

        kino_abduction = true,
        kino_sci_fi = true,
        kino_action = true,
        kino_crime = true,
    
        all_kino_vouchers = true,

        -- vanilla content
        vanilla_space = true,
        vanilla_science = true,
        vanilla_kino_tarots = true,
        -- all_vanilla_tags = true,
        all_vanilla_vouchers = true,
        all_vanilla_planets = true,
        all_vanilla_spectrals = true,

        -- BANNED PACKAGES
        kino_spellcasting = false,
        kino_mystery = false,
        kino_demonic = false,
        kino_horror = false,
        kino_romance = false,
        kino_superhero = false,
    },
    mods = {
        "Vanilla",
        "kino"
    }
}

-- Enhancements:

-- Sci-fi
-- Gold
-- Action
-- Crime
-- Steel

-- Stone
-- Glass
-- Bonus
-- Mult
-- Wild

-- Planets:
-- All vanilla
-- All Kino except Thra

-- Confections:
-- REMOVE: Magic Beans, Candy Corn, Sour Candy

-- Seals:
-- Remove Thriller
-- Remove Sports
-- Remove Cheese
