SMODS.Booster {
    key = "action_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "action_booster",
    pos = {x = 0, y = 1},
    config = {
        extra = 3,
        choose = 1,
        genre = "Action"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return self.weight * 10

        elseif #G.GAME.modifiers.genre_bonus >= 1 and not genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = false,
    create_card = function(self, card)
        return create_card("Action", G.pack_cards, nil, nil, true, true, nil, "buf")
    end
}

SMODS.Booster {
    key = "comedy_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "comedy_booster",
    pos = {x = 0, y = 3},
    config = {
        extra = 3,
        choose = 1,
        genre = "Comedy"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return self.weight * 10

        elseif #G.GAME.modifiers.genre_bonus >= 1 and not genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = false,
    create_card = function(self, card)
        return create_card("Comedy", G.pack_cards, nil, nil, true, true, nil, "buf")
    end
}

SMODS.Booster {
    key = "horror_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "horror_booster",
    pos = {x = 0, y = 0},
    config = {
        extra = 3,
        choose = 1,
        genre = "Horror"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and G.GAME.modifiers.genre_bonus == self.config.genre then
            return self.weight * 10

        elseif #G.GAME.modifiers.genre_bonus >= 1 and G.GAME.modifiers.genre_bonus ~= self.config.genre then
            return 0

        end
        return self.weight
    end,
    unlocked = true,
    discovered = false,
    create_card = function(self, card)
        return create_card("Horror", G.pack_cards, nil, nil, true, true, nil, "buf")
    end
}

SMODS.Booster {
    key = "romance_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "romance_booster",
    pos = {x = 0, y = 4},
    config = {
        extra = 3,
        choose = 1,
        genre = "Romance"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return self.weight * 10

        elseif #G.GAME.modifiers.genre_bonus >= 1 and not genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = false,
    create_card = function(self, card)
        return create_card("Romance", G.pack_cards, nil, nil, true, true, nil, "buf")
    end
}

SMODS.Booster {
    key = "sci_fi_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "sci_fi_booster",
    pos = {x = 0, y = 2},
    config = {
        extra = 3,
        choose = 1,
        genre = "Sci-fi"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return self.weight * 10

        elseif #G.GAME.modifiers.genre_bonus >= 1 and not genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = false,
    create_card = function(self, card)
        return create_card("Sci-fi", G.pack_cards, nil, nil, true, true, nil, "buf")
    end
}

SMODS.Booster {
    key = "fantasy_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "fantasy_booster",
    pos = {x = 0, y = 5},
    config = {
        extra = 3,
        choose = 1,
        genre = "Fantasy"
    },
    cost = 4,
    order = 1,
    weight = 1,
    get_weight = function(self, weight, object_type)
        if G.GAME.modifiers.genre_bonus and genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return self.weight * 10

        elseif #G.GAME.modifiers.genre_bonus >= 1 and not genre_match(G.GAME.modifiers.genre_bonus, self.config.genre) then
            return 0
        end
        return self.weight
    end,
    unlocked = true,
    discovered = false,
    create_card = function(self, card)
        return create_card("Fantasy", G.pack_cards, nil, nil, true, true, nil, "buf")
    end
}

SMODS.Booster {
    key = "actor_booster",
    kind = "Joker",
    atlas = "kino_boosters",
    group_key = "actor_booster",
    pos = {x = 0, y = 6},
    config = {
        extra = 3,
        choose = 1,
    },
    cost = 4,
    order = 1,
    weight = 1,
    unlocked = true,
    discovered = false,
    in_pool = function(self, args)
        if not G.jokers or not G.jokers.cards then
            return false
        end
        
        local _castlist = create_cast_list()
        local _pool = {}

        for _key, _object in pairs(G.P_CENTERS) do
            if _object.set == "Joker" and _object.k_genre then
                if _object and has_cast_from_table(_object, _castlist) then
                    _pool[#_pool + 1] = _key
                end
            end

            if #_pool >= 6 then
                return true
            end
        end

        return false
    end,
    create_card = function(self, card)
        local _castlist = create_cast_list()
        local _pool = {}

        for _key, _object in pairs(G.P_CENTERS) do
            if _object.set == "Joker" and _object.k_genre then
                if _object and has_cast_from_table(_object, _castlist) then
                    _pool[#_pool + 1] = _key
                end
            end
        end


        local _key = SMODS.poll_object({pool = _pool})
        return SMODS.create_card({type = "Joker", area = G.pack_cards, key = _key})
    end
}