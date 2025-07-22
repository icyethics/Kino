SMODS.Joker {
    key = "batman_mask_of_the_phantasm",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            cur_chance = 1,
            chance = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 14919,
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
    k_genre = {"Superhero", "Animation", "Mystery"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.cur_chance, card.ability.extra.chance, "kino_joker_manipulation")
          
        return {
            vars = {
                new_numerator,
                new_denominator,
                math.max(new_denominator - new_numerator, 0)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local _mypos = nil
                for _index, _joker in ipairs(G.jokers.cards) do
                    if _joker == card then
                        _mypos = _index
                    end
                end
            if G.jokers.cards[_mypos + 1] and not 
            kino_quality_check(G.jokers.cards[_mypos + 1], "is_batman") and not
            G.jokers.cards[_mypos + 1].config.center == G.P_CENTERS.j_joker then
                local _target = G.jokers.cards[_mypos + 1]

                -- if pseudorandom("kino_batphant") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
                if SMODS.pseudorandom_probability(card, 'kino_batphant', card.ability.extra.cur_chance, card.ability.extra.chance, "kino_joker_manipulation") then
                    local _pooled_card = Kino.get_complex_card("kino_batman", nil, "kino_phantmask")
                    _target:set_ability(_pooled_card)
                else
                    _target:set_ability("j_joker")
                end

            end
        end
    end
}