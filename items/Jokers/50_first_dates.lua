SMODS.Joker {
    key = "50_first_dates",
    order = 151,
    config = {
        extra = {
            repetitions = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    pools, k_genre = {"Romance", "Comedy"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- Romance cards trigger twice
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if SMODS.has_enhancement(context.other_card, "m_kino_romance") then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.repetitions,
                    card = context.other_card
                }
            end
        end
    end
}