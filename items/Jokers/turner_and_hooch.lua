SMODS.Joker {
    key = "turner_and_hooch",
    order = 33,
    config = {
        extra = {
            is_turner = true,
            evidence = 0,
            mult = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.is_turner,
                card.ability.extra.evidence,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Alternates between Turner & Hooch after each hand played.
        -- Turner: Turner, gather evidence. 1 evidence for each card played.
        -- Hooch: Each card gives mult equal to evidence.

        if context.individual then
            -- Turner
            if card.ability.extra.is_turner and not context.blueprint then
                card.ability.extra.evidence = card.ability.extra.evidence + 1
            else
                return {
                    mult = card.ability.extra.evidence
                }
            end
            -- Hooch
        end

        if context.after then
            if card.ability.extra.is_turner then
                card.ability.extra.is_turner = false
            else
                card.ability.extra.is_turner = true
            end
        end

    end
}