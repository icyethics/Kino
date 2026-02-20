
G.C.KINO = {
    ACTION = HEX("0a4a59"),
    ADVENTURE = HEX("aa5d23"),
    ANIMATION = HEX("c1d07a"),
    BIOPIC = HEX("6461f7"), 
    COMEDY = HEX("420690"),
    CHRISTMAS = HEX("cc1d49"),
    CRIME = HEX("6a4c47"),
    DRAMA = HEX("694c77"),
    FAMILY = HEX("e7b9c6"),
    FANTASY = HEX("087ad9"),
    HISTORICAL = HEX("733c13"), 
    HORROR = HEX("372a2d"),
    MUSICAL = HEX("ae327f"), 
    MYSTERY = HEX("7d17dd"),
    ROMANCE = HEX("c8117d"),
    SCIFI = HEX("1eddd4"),
    SILENT = HEX("888888"),
    SPORTS = HEX("cc9c37"), 
    SUPERHERO = HEX("4c71ee"),
    THRILLER = HEX("078084"),
    WESTERN = HEX("735b48"),
    
    PINK = HEX("f7b7f2"),
    MAGIC = HEX("7F00FF"),
    ALIEN = HEX("71d027"),
    CONFECTION = HEX("8e1212"),
    DRAIN = HEX("b52727"),
    HEARTACHE = HEX("d586c6"),
    STRANGE_PLANET_COLOUR = HEX("1b9d6e"),
    BULLET = HEX("899dbb"),
    POWER = HEX("8862ab"),
    JUMPSCARE = HEX("db4949"),

    SILVER_BASE = HEX("d3d3d3"),
    SILVER_DARK = HEX("8e9393"),
    KINO_ORANGE = HEX("ff992f"),
    KINO_PURPLE = HEX("a445db"),

    KINO_FROST_LIGHT = HEX("a1d7e4"),
    KINO_FROST_DARK = HEX("7dc1d1"),
    KINO_FIRE_RED = HEX("df6464"),
    KINO_FIRE_YELLOW = HEX("ffe38a")

}

SMODS.Gradient({
    key = "STRANGE_PLANET",
    colours = { G.C.SECONDARY_SET.Planet, G.C.KINO.STRANGE_PLANET_COLOUR},
    cycle = 2.5,
})

SMODS.Gradient({
    key = "SILVER_SCREEN",
    colours = { G.C.KINO.SILVER_BASE, G.C.KINO.SILVER_DARK},
    cycle = 2.5,
})

SMODS.Gradient({
    key = "KINO_GRADIENT",
    colours = { G.C.KINO.KINO_ORANGE, G.C.KINO.KINO_PURPLE},
    cycle = 2.5,
})

SMODS.Gradient({
    key = "KINO_FROST",
    colours = { G.C.KINO.KINO_FROST_LIGHT, G.C.KINO.KINO_FROST_DARK},
    cycle = 0.5,
})

SMODS.Gradient({
    key = "KINO_BURN",
    colours = { G.C.KINO.KINO_FIRE_RED, G.C.KINO.KINO_FIRE_YELLOW},
    cycle = 2.5,
})

SMODS.Gradient({
    key = "KINO_JUMPSCARE",
    colours = { G.C.KINO.JUMPSCARE, G.C.L_BLACK},
    cycle = 2.5,
})
SMODS.Gradient({
    key = "KINO_CHAINS",
    colours = { HEX("a1c3c1"), HEX("9b9b9b")},
    cycle = 2.5,
})

G.C.KINO.STRANGE_PLANET = SMODS.Gradients.kino_STRANGE_PLANET
G.C.KINO.SILVER_SCREEN = SMODS.Gradients.kino_SILVER_SCREEN
G.C.KINO.KINO_GRADIENT = SMODS.Gradients.kino_KINO_GRADIENT
G.C.KINO.KINO_FROST = SMODS.Gradients.kino_KINO_FROST
G.C.KINO.KINO_BURN = SMODS.Gradients.kino_KINO_BURN
G.C.KINO.KINO_JUMPSCARE = SMODS.Gradients.kino_KINO_JUMPSCARE
G.C.KINO.KINO_CHAINS = SMODS.Gradients.kino_KINO_CHAINS

local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["Action"] = G.C.KINO.ACTION
    G.ARGS.LOC_COLOURS["Adventure"] = G.C.KINO.ADVENTURE
    G.ARGS.LOC_COLOURS["Animation"] = G.C.KINO.ANIMATION
    G.ARGS.LOC_COLOURS["Biopic"] = G.C.KINO.BIOPIC
    G.ARGS.LOC_COLOURS["Comedy"] = G.C.KINO.COMEDY
    G.ARGS.LOC_COLOURS["Christmas"] = G.C.KINO.CHRISTMAS
    G.ARGS.LOC_COLOURS["Crime"] = G.C.KINO.CRIME
    G.ARGS.LOC_COLOURS["Drama"] = G.C.KINO.DRAMA
    G.ARGS.LOC_COLOURS["Family"] = G.C.KINO.FAMILY
    G.ARGS.LOC_COLOURS["Fantasy"] = G.C.KINO.FANTASY
    G.ARGS.LOC_COLOURS["Historical"] = G.C.KINO.HISTORICAL
    G.ARGS.LOC_COLOURS["Horror"] = G.C.KINO.HORROR
    G.ARGS.LOC_COLOURS["Musical"] = G.C.KINO.MUSICAL
    G.ARGS.LOC_COLOURS["Mystery"] = G.C.KINO.MYSTERY
    G.ARGS.LOC_COLOURS["Romance"] = G.C.KINO.ROMANCE
    G.ARGS.LOC_COLOURS["Sci-fi"] = G.C.KINO.SCIFI
    G.ARGS.LOC_COLOURS["Silent"] = G.C.KINO.SILENT
    G.ARGS.LOC_COLOURS["Sports"] = G.C.KINO.SPORTS
    G.ARGS.LOC_COLOURS["Superhero"] = G.C.KINO.SUPERHERO
    G.ARGS.LOC_COLOURS["Thriller"] = G.C.KINO.THRILLER
    G.ARGS.LOC_COLOURS["Western"] = G.C.KINO.WESTERN
    G.ARGS.LOC_COLOURS["Magic"] = G.C.KINO.MAGIC
    G.ARGS.LOC_COLOURS["Alien"] = G.C.KINO.ALIEN
    G.ARGS.LOC_COLOURS["Confection"] = G.C.KINO.CONFECTION
    G.ARGS.LOC_COLOURS["Drain"] = G.C.KINO.DRAIN
    G.ARGS.LOC_COLOURS["Heartache"] = G.C.KINO.HEARTACHE
    G.ARGS.LOC_COLOURS["StrangePlanet"] = G.C.KINO.STRANGE_PLANET
    G.ARGS.LOC_COLOURS["SilverScreen"] = G.C.KINO.SILVER_SCREEN
    G.ARGS.LOC_COLOURS["Bullet"] = G.C.KINO.BULLET
    G.ARGS.LOC_COLOURS["Power"] = G.C.KINO.POWER
    G.ARGS.LOC_COLOURS["Frost"] = G.C.KINO.KINO_FROST
    G.ARGS.LOC_COLOURS["Burn"] = G.C.KINO.KINO_BURN
    G.ARGS.LOC_COLOURS["Jumpscare"] = G.C.KINO.KINO_JUMPSCARE
    G.ARGS.LOC_COLOURS["Chain"] = G.C.KINO.KINO_CHAINS

    return genrecolors(_c, _default)
end