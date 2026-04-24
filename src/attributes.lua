-- Reworked to also check for attributes
function kino_quality_check(card, quality)
    -- Hardcode in some specific vanilla jokers to count
    if quality == "is_wet" and 
    (card.config.center == G.P_CENTERS.j_selzer or
    card.config.center == G.P_CENTERS.j_splash or
    card.config.center == G.P_CENTERS.j_diet_cola) then
        return true
    end
    if card and card.config and card.config[quality] and card.config[quality] ~= false then
        return true
    end
    if card and card.ability and card.ability[quality] and card.ability[quality] ~= false then
        return true
    end
    if card.has_attribute and card:has_attribute(quality) then
        return true
    end
    if card and card.attributes and card.attributes[quality] then
        return true
    end
    return false
end

SMODS.Attribute {
    key = "batman",
    keys = {
        "j_kino_batman_66", "j_kino_batman_1989", "j_kino_batman_2022",
        "j_kino_batman_and_robin", "j_kino_batman_begins", "j_kino_batman_forever",
        "j_kino_batman_killing_joke", "j_kino_batman_mask_of_the_phantasm",
        "j_kino_batman_returns", "j_kino_batmanvsuperman", "j_kino_dark_knight_returns",
        "j_kino_dark_knight", "j_kino_joker"
    },
    alias = {"is_batman"}
}

SMODS.Attribute {
    key = "starwars",
    keys = {
        "j_kino_rogue_one", "j_kino_solo", "j_kino_star_wars_clone_wars",
        "j_kino_holiday", "j_kino_star_wars_i", "j_kino_star_wars_ii",
        "j_kino_star_wars_iii", "j_kino_star_wars_iv", "j_kino_star_wars_v",
        "j_kino_star_wars_vi", "j_kino_star_wars_vii", "j_kino_star_wars_viii",
        "j_kino_star_wars_ix"
    },
    alias = {"is_starwars", "is_star_wars", "star_wars"}
}

SMODS.Attribute {
    key = "vampire",
    keys = {
        "j_vampire", "j_kino_30_days_of_night", "j_kino_blade_1",
        "j_kino_cronos", "j_kino_dracula_1931_2", "j_kino_dracula_1931",
        "j_kino_fright_night", "j_kino_morbius", "j_kino_nosferatu_1",
        "j_kino_nosferatu_2024", "j_kino_only_lovers_left_alive",
        "j_kino_sinners", "j_kino_twilight_1", "j_kino_what_we_do_in_the_shadows",
    },
    alias = {"is_vampire"}
}

SMODS.Attribute {
    key = "wet",
    keys = {
        "j_kino_abyss", "j_kino_castaway", "j_kino_creature_from_the_black_lagoon",
        "j_kino_gremlins_1", "j_kino_jaws", "j_kino_piranha_2", "j_kino_ponyo",
        "j_kino_waterworld", "j_selzer", "j_splash", "j_diet_cola"
    },
    alias = {"is_wet"}
}

SMODS.Attribute {
    key = "superman",
    keys = {
        "j_kino_batmanvsuperman", "j_kino_superman_1978", "j_kino_superman_2025"
    },
    alias = {"is_superman"}
}

SMODS.Attribute {
    key = "pirate",
    keys = {
        "j_kino_captain_blood", "j_kino_hook", "j_kino_muppets_treasure_island",
        "j_kino_pirates_movie", "j_kino_pirates_of_the_caribbean_1", "j_kino_pirates_of_the_caribbean_2",
        "j_kino_pirates_of_the_caribbean_3", "j_kino_treasure_island", "j_kino_treasure_planet",
        "j_swashbuckler"
    },
    alias = "is_pirate"
}