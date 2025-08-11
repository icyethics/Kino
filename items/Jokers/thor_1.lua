SMODS.Joker {
    key = "thor_1",
    order = 149,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            repetitions = 3,
            chosen_card = nil,
            chosen_index = nil,
            index = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 4, y = 0},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    is_marvel = true,
    kino_joker = {
        id = 10195,
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
    pools, k_genre = {"Superhero", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and 
        context.before and not context.repetition and not context.blueprint and 
        context.scoring_hand and #context.scoring_hand > 2 then
            -- card.ability.extra.chosen_card = pseudorandom_element(context.scoring_hand, pseudoseed("thor"))
            local _chosencard = pseudorandom_element(context.scoring_hand, pseudoseed("thor"))
            _chosencard.marked_by_thor = true
        end

        if context.cardarea == G.play and context.repetition and not context.repetition_only and
        context.other_card and context.other_card.marked_by_thor == true and 
        context.scoring_hand and #context.scoring_hand > 2 then
            context.other_card.marked_by_thor = nil
            return {
                message = 'This card... I like it!',
                repetitions = card.ability.extra.repetitions,
                card = context.other_card
            }
        end


    end
}