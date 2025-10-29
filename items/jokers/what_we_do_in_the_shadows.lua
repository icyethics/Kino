SMODS.Joker {
    key = "what_we_do_in_the_shadows",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            a_chips = 3,
            chance = 5,
            base_chance = 5
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 5, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 246741,
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
    k_genre = {"Horror", "Comedy"},

    loc_vars = function(self, info_queue, card)

        info_queue[#info_queue + 1]  = {set = 'Other', key = "keyword_drain"}    
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.base_chance, card.ability.extra.chance, "kino_drain")
        
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.a_chips,
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- First scored card each hand
        -- 5/5 chance to drain 1 rank from a card and gain +3 chips
        -- Repeats until failed

        if context.before
        and context.scoring_hand
        and #context.scoring_hand >= 1
        and not context.blueprint and not context.repetition then
            local _target = context.scoring_hand[1]
            local _current_chance = card.ability.extra.base_chance
            local _hasfailed = false
            while _current_chance > 0 and _target:get_id() > 2 and not _hasfailed do
                if SMODS.pseudorandom_probability(card, 'kino_wwdits', _current_chance, card.ability.extra.chance, "kino_drain") then
                    _current_chance = _current_chance - 1
                    if Kino.drain_property(_target, card, {Rank = {Intensity = 1, repeatable = true}}) then
                        card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips 
                    end
                else
                   _hasfailed = true 
                end
            end   
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
        -- 

    end
}