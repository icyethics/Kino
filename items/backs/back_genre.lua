Kino.deck_list = {
    -- tarots
    {key = "spooky", genre = "Horror", coords = {x = 0, y = 0}, consumables = {"c_kino_slasher", "c_kino_demon"}},
    {key = "tech", genre = "Sci-fi", coords = {x = 1, y = 0}, consumables = {"c_kino_droid", "c_kino_droid"}},
    {key = "flirty", genre = "Romance", coords = {x = 2, y = 0}, consumables = {"c_kino_meetcute", "c_kino_meetcute"}},
    {key = "questionable", genre = "Mystery", coords = {x = 3, y = 0}, consumables = {"c_kino_detective", "c_kino_detective"}},
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
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                _info.genre,
                3,
                colours = {
                    G.ARGS.LOC_COLOURS and G.ARGS.LOC_COLOURS[_info.genre] or nil
                }
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _tally = 0
            for i, _joker in ipairs(G.jokers.cards) do
                if is_genre(_joker, _info.genre) then
                    _tally = _tally + 1
                end
            end
            if _tally >= 3 then
                unlock_card(self)
            end
        end
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

