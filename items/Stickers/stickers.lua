SMODS.Sticker{ -- bacon sticker
    key = 'bacon',

    apply = function(self, card, val)
        if card.ability.kino_bacon then return end
        card.ability[self.key] = val
    end,

    badge_colour = HEX('9eacbe'),
    no_collection = true,
    

    order = 5,

    pos = { x = 0, y = 0},
    atlas = 'kino_stickers'
}

SMODS.Sticker{
    key = 'award',

    apply = function(self, card, val)
        -- once the increase val function for kino jokers is implemented
        -- this should increase by x2

        if card.ability.kino_award then return end
        card.ability[self.key] = val
        print(card.ability[self.key])
        card:set_multiplication_bonus(card)
    end,
    badge_colour = HEX('ffd081'),
    no_collection = true,

    order = 6,

    pos = { x = 1, y = 0},
    atlas = 'kino_stickers'
}

SMODS.Sticker{
    key = 'choco',

    apply = function(self, card, val)
        if card.ability.set ~= "confection" or 
        card.ability.kino_choco then return end
        card.ability[self.key] = val
    end,
    hide_badge = true,
    badge_colour = HEX('ffd081'),
    no_collection = true,

    order = 7,

    pos = { x = 2, y = 0},
    atlas = 'kino_stickers'
}

SMODS.Sticker{
    key = 'goldleaf',

    apply = function(self, card, val)
        if card.ability.set ~= "confection" or 
        card.ability.kino_goldleaf then return end
        card.ability[self.key] = val
    end,
    hide_badge = true,
    badge_colour = HEX('ffd081'),
    no_collection = true,

    order = 8,

    pos = { x = 3, y = 0},
    atlas = 'kino_stickers'
}

SMODS.Sticker{
    key = 'extra_large',

    apply = function(self, card, val)
        if card.ability.set ~= "confection" or 
        card.ability.kino_extra_large then return end
        card.ability[self.key] = val
    end,
    hide_badge = true,
    badge_colour = HEX('ffd081'),
    no_collection = true,

    order = 9,

    pos = { x = 4, y = 0},
    atlas = 'kino_stickers'
}