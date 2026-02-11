SMODS.Stake {
    name = "Silver Stake",
    key = "silver",
    applied_stakes = { "gold" },
    atlas = "kino_stakes",
    sticker_atlas = "kino_stickers",
    pos = { x = 0, y = 0},
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.kino_boss_rush = true
        G.GAME.modifiers.kino_end_credits = true
    end,
    colour = G.C.KINO.SILVER_SCREEN,
    shiny = true,
}