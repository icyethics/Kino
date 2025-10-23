SMODS.Joker {
    key = "cronos",
    order = 166,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 3, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11655,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    k_genre = {"Horror"},
    is_vampire = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- If you play a single card, drain half its rank and gain x5 chips for each rank drained
        if context.before
        and context.full_hand
        and #context.full_hand == 1
        and not context.blueprint and not context.repetition then
            local i_card = context.scoring_hand[1]
            local rank = i_card.base.id
            local _halfrank = math.max(math.floor(rank / 2), 2)

            if i_card.base.id == 2 then
                return {
                    
                }
            end

            if Kino.drain_property(i_card, card, {Rank = {Intensity = _halfrank}}) then
                card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + (rank - _halfrank) *card.ability.extra.a_chips 
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
    end
}