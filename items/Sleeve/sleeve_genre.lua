if CardSleeves then
    CardSleeves.Sleeve {
        key = "spooky",
        atlas = "kino_sleeves",
        pos = { x = 0, y = 0 },
        config = {
            genre_bonus = "Horror"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Horror"
            G.GAME.kino_genre_weight["Horror"] = (1 + G.GAME.kino_genre_weight["Horror"]) * 3
        end
    }

    CardSleeves.Sleeve {
        key = "flirty",
        atlas = "kino_sleeves",
        pos = { x = 1, y = 0 },
        config = {
            genre_bonus = "Romance"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Romance"
            G.GAME.kino_genre_weight["Romance"] = (1 + G.GAME.kino_genre_weight["Romance"]) * 3
        end
    }

    CardSleeves.Sleeve {
        key = "dangerous",
        atlas = "kino_sleeves",
        pos = { x = 2, y = 0 },
        config = {
            genre_bonus = "Action"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Action"
            G.GAME.kino_genre_weight["Action"] = (1 + G.GAME.kino_genre_weight["Action"]) * 3
        end
    }

    CardSleeves.Sleeve {
        key = "tech",
        atlas = "kino_sleeves",
        pos = { x = 3, y = 0 },
        config = {
            genre_bonus = "Sci-fi"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Sci-fi"
            G.GAME.kino_genre_weight["Sci-fi"] = (1 + G.GAME.kino_genre_weight["Sci-fi"]) * 3
        end
    }

    CardSleeves.Sleeve {
        key = "enchanted",
        atlas = "kino_sleeves",
        pos = { x = 4, y = 0 },
        config = {
            genre_bonus = "Fantasy"
        },
        apply = function(self, sleeve)
            G.GAME.modifiers.genre_bonus[#G.GAME.modifiers.genre_bonus + 1] = "Fantasy"
            G.GAME.kino_genre_weight["Fantasy"] = (1 + G.GAME.kino_genre_weight["Fantasy"]) * 3
        end
    }
end