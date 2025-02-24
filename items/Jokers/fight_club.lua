SMODS.Joker {
    key = "fight_club",
    order = 35,
    config = {
        extra = {
            x_mult = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_1",
    pos = { x = 4, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Thriller", "Action"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- x3, and destroy a random scored card. (Code by Eremel)
        if context.joker_main then
            -- Select a random card
            pseudorandom_element(context.scoring_hand).marked_to_destroy_by_fight_club = true
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.destroying_card and context.destroying_card.marked_to_destroy_by_fight_club then
            return { remove = true }
        end
    end
}