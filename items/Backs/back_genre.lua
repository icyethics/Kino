-- SMODS.Back {
--     name = "Spooky Deck",
--     key = "spooky",
--     atlas = "kino_backs",
--     pos = {x = 0, y = 0},
--     config = {
--         genre_bonus = "Horror"
--     },
--     apply = function()
--         G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Horror"
--         G.GAME.kino_genre_weight["Horror"] = (1 + G.GAME.kino_genre_weight["Horror"]) * 3
--     end
-- }

-- SMODS.Back {
--     name = "Flirty Deck",
--     key = "flirty",
--     atlas = "kino_backs",
--     pos = {x = 1, y = 0},
--     config = {
--         genre_bonus = "Romance"
--     },
--     apply = function()
--         G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Romance"
--         G.GAME.kino_genre_weight["Romance"] = (1 + G.GAME.kino_genre_weight["Romance"]) * 3
--     end
-- }

-- SMODS.Back {
--     name = "Dangerous Deck",
--     key = "dangerous",
--     atlas = "kino_backs",
--     pos = {x = 2, y = 0},
--     config = {
--         genre_bonus = "Action"
--     },
--     apply = function()
--         G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Action"
--         G.GAME.kino_genre_weight["Action"] = (1 + G.GAME.kino_genre_weight["Action"]) * 3
--     end
-- }

-- SMODS.Back {
--     name = "Tech Deck",
--     key = "tech",
--     atlas = "kino_backs",
--     pos = {x = 3, y = 0},
--     config = {
--         genre_bonus = "Sci-fi"
--     },
--     apply = function()
--         G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Sci-fi"
--         G.GAME.kino_genre_weight["Sci-fi"] = (1 + G.GAME.kino_genre_weight["Sci-fi"]) * 3
--     end
-- }

-- SMODS.Back {
--     name = "Enchanted Deck",
--     key = "enchanted",
--     atlas = "kino_backs",
--     pos = {x = 4, y = 0},
--     config = {
--         genre_bonus = "Fantasy"
--     },
--     apply = function()
--         G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Fantasy"
--         G.GAME.kino_genre_weight["Fantasy"] = (1 + G.GAME.kino_genre_weight["Fantasy"]) * 3
--     end
-- }

Kino.deck_list = {
    -- tarots
    {key = "spooky", genre = "Horror", coords = {x = 0, y = 0}, consumables = {"c_kino_slasher", "c_kino_demon"}},
    {key = "tech", genre = "Sci-fi", coords = {x = 1, y = 0}, consumables = {"c_kino_droid", "c_kino_droid"}},
    {key = "flirty", genre = "Romance", coords = {x = 2, y = 0}, consumables = {"c_kino_meetcute", "c_kino_meetcute"}},
    {key = "questionable", genre = "Mystery", coords = {x = 3, y = 0}, consumables = {"c_kino_mystery", "c_kino_mystery"}},
    {key = "enchanted", genre = "Fantasy", coords = {x = 4, y = 0}, consumables = {"c_kino_witch", "c_kino_witch"}},
    {key = "illicit", genre = "Crime", coords = {x = 5, y = 0}, consumables = {"c_kino_gangster", "c_kino_gangster"}},
    {key = "dangerous", genre = "Action", coords = {x = 0, y = 1}, consumables = {"c_kino_soldier", "c_kino_soldier"}},
    {key = "heroic", genre = "Superhero", coords = {x = 1, y = 1}, consumables = {"c_kino_superhero", "c_kino_superhero"}},

    -- spectrals
    {key = "athletic", genre = "Sports", coords = {x = 2, y = 1}, consumables = {"c_kino_homerun", "c_kino_homerun"}},
    {key = "childlike", genre = "Family", coords = {x = 3, y = 1}, consumables = {"c_kino_gathering", "c_kino_gathering"}},
    {key = "adventurous", genre = "Adventure", coords = {x = 4, y = 1}, consumables = {"c_kino_artifact", "c_kino_artifact"}},
    {key = "highpressure", genre = "Thriller", coords = {x = 5, y = 1}, consumables = {"c_kino_fright", "c_kino_fright"}},
    {key = "funny", genre = "Comedy", coords = {x = 0, y = 2}, consumables = {"c_kino_whimsy", "c_kino_whimsy"}},
}

for _index, _info in ipairs(Kino.deck_list) do

    SMODS.Back {
    key = _info.key,
    atlas = "kino_backs_genre",
    pos = _info.coords,
    config = {
        genre_bonus = _info.genre,
        consumables = _info.consumables,
    },
    apply = function()
        G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = _info.genre
        G.GAME.kino_genre_weight[_info.genre] = (1 + G.GAME.kino_genre_weight[_info.genre]) * 3
    end,
}
end
-- Horror
-- Sci-fi
-- Romance
-- Mystery
-- Fantasy
-- Crime

-- Action
-- Superhero
-- Sports
-- Family
-- Adventure
-- Thriller

-- Comedy

