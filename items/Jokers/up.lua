SMODS.Joker {
    key = "up",
    order = 261,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 2, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 14160,
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
    pools, k_genre = {"Animation", "Family", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        -- your highest card scores two additional times
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            local _rank = context.other_card:get_id()
            local _handplacement = nil
            local _isheighest = true
            local _isfinal = nil

            for _, _pcard in ipairs(context.scoring_hand) do
                if _rank < _pcard:get_id() then
                    _isheighest = false
                    break
                end
                if _rank == _pcard:get_id() and
                _isfinal == true then
                    context.other_card:juice_up()
                    _isfinal = false
                    break
                end
                if _pcard == context.other_card then
                    _isfinal = true
                end

            end

            if _isheighest and _isfinal then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.repetitions,
                }
            end
        end
    end
}