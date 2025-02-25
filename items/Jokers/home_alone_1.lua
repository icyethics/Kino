SMODS.Joker {
    key = "home_alone_1",
    order = 28,
    config = {
        extra = {
            chips = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 1, y = 5},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Christmas", "Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a high card, add its chips to this joker
        if context.individual and context.cardarea == G.play and
        context.scoring_name == "High Card" and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + context.other_card:get_id()
            return {
                message = localize('k_upgrade_ex'),
                card = card,
                colour = G.C.CHIPS
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                card = card
            }

        end
    end
}