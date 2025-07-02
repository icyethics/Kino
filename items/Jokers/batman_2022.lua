SMODS.Joker {
    key = "batman_2022",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            repetitions = 1,
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 1, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 414906,
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
    pools = {["kino_batman"] = true}, 
    k_genre = {"Superhero", "Mystery", "Action"},

    loc_vars = function(self, info_queue, card)

        local _count = 0
        if G.jokers then
            _count = G.jokers.config.card_limit - #G.jokers.cards
            for _index, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_batman") then
                    _count = _count + 1
                end
            end
        end

        return {
            vars = {
                card.ability.extra.repetitions,
                _count
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and 
        context.before and not context.repetition and not context.blueprint and 
        context.scoring_hand then
            
            local _count = G.jokers.config.card_limit - #G.jokers.cards
            for _index, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, "is_batman") then
                    _count = _count + 1
                end
            end

            for i = 1, _count do
                local _chosencard = pseudorandom_element(context.scoring_hand, pseudoseed("kino_batman22"))
                _chosencard.marked_by_batman22 = _chosencard.marked_by_batman22 or {}
                _chosencard.marked_by_batman22[card.ID] = _chosencard.marked_by_batman22[card.ID] or 0
                _chosencard.marked_by_batman22[card.ID] = _chosencard.marked_by_batman22[card.ID] + card.ability.extra.repetitions
                -- _chosencard.marked_by_batman22 = (_chosencard.marked_by_batman22 and _chosencard.marked_by_batman22[card.ID]) and _chosencard.marked_by_batman22[card.ID] or {[card.ID] = 0} 
            end
            
        end

        if context.cardarea == G.play and context.repetition and not context.repetition_only and
        context.other_card.marked_by_batman22 and context.other_card.marked_by_batman22[card.ID] then
            local _reps = context.other_card.marked_by_batman22[card.ID]
            context.other_card.marked_by_batman22[card.ID] = 0
            return {
                message = 'Again!',
                repetitions = _reps,
                card = context.other_card
            }
        end
        
    end
}