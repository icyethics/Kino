SMODS.Joker {
    key = "se7en",
    order = 74,
    config = {
        extra = {
            mult = 7,
            sevens_trig = 0,
            sevens_trig_cap = 49
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 1, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Thriller", "Mystery"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- 7s give +7 mult

        if context.individual and context.other_card:get_id() == 7 then
            card.ability.extra.sevens_trigs = card.ability.extra.sevens_trigs + 1

            if card.ability.extra.sevens_trigs == card.ability.extra.sevens_trigs_cap then
                card.ability.extra.sevens_trigs = 0
                return {
                    x_mult = card.ability.extra.mult
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}