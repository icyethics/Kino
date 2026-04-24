SMODS.Stake {
    name = "Silver Stake",
    key = "silver",
    unlocked_stake = "gold",
    applied_stakes = { "gold" },
    above_stake = 'gold',
    atlas = "kino_stakes",
    sticker_atlas = "kino_stickers",
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    pos = { x = 0, y = 0},
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.kino_boss_rush = true
        G.GAME.modifiers.kino_end_credits = true
    end,
    colour = G.C.KINO.SILVER_SCREEN,
    shiny = true,
}