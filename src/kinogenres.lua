function kino_genre_init()

-- Iterate over all the jokers, and put them in the correct genre bundle

-- Dynamically create the objects?
-- Genres are identical to each other, other in key and name
kino_genres = {
    "Action",
    "Adventure",
    "Animation",
    "Biopic",
    "Comedy",
    "Christmas",
    "Crime",
    "Drama",
    "Family",
    "Fantasy",
    "Historical",
    "Horror",
    "Musical",
    "Mystery",
    "Romance",
    "Sci-fi",
    "Silent",
    "Sports",
    "Superhero",
    "Thriller",
    "Western"
}

for _, _key in ipairs(Kino.jokers) do
    if SMODS.Centers[_key] and SMODS.Centers[_key].k_genre then
        SMODS.Centers[_key].pools = {}
        for __, _genre in ipairs(SMODS.Centers[_key].k_genre) do
            SMODS.Centers[_key].pools[_genre] = true
        end
    end
end

-- Creates an object for each genre
for i, genre in ipairs(kino_genres) do
    local genre_config = {
        key = genre,
        default = "j_jimbo",
        -- cards = {},
        rarities = {
            { key = "Common" },
            { key = "Uncommon" },
            { key = "Rare" },
        },
    }

    SMODS["ObjectType"](genre_config)
    
    local attribute_config = {
        key = genre
    }
    SMODS["Attribute"](attribute_config)
end

for _, _key in ipairs(Kino.jokers) do
    if SMODS.Centers[_key] and SMODS.Centers[_key].k_genre then
        for __, _genre in ipairs(SMODS.Centers[_key].k_genre) do
            SMODS.add_attribute(_genre, {_key})
        end
    end
end

end