SMODS.Joker {
    key = "annihilation",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chance_cur = 1,
            chance = 4
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 1, y = 3},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 300668,
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
    pools, k_genre = {"Sci-fi", "Horror"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.chance_cur, card.ability.extra.chance, "kino_card_manipulation")
          
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- cards have a 1/4 chance to gain the Seal, Edition, Enhancement, Suit or Rank of the first scoring card
        if context.after and context.cardarea == G.jokers then
            
            -- iterate through the cards
            for _index, _pcard in ipairs(context.scoring_hand) do
            
                if _index > 1 then
                    local _basecard = context.scoring_hand[1]
                    local _changes = false
                    
                    -- rank check
                    if not _basecard.config.center.overrides_base_rank then

                        if SMODS.pseudorandom_probability(card, 'kino_annihilation', card.ability.extra.chance_cur, card.ability.extra.chance, "kino_card_manipulation") then
    
                            SMODS.modify_rank(_pcard, nil, _basecard:get_id())
                            _changes = true
                        end
                    end

                    -- suit check
                    if not _basecard.config.center.no_suit and not _basecard.config.center.any_suit then
                        if SMODS.pseudorandom_probability(card, 'kino_annihilation', card.ability.extra.chance_cur, card.ability.extra.chance, "kino_card_manipulation") then
                            SMODS.change_base(_pcard, _basecard.base.suit)
                            _changes = true
                        end
                    end


                    -- seal check
                    if SMODS.pseudorandom_probability(card, 'kino_annihilation', card.ability.extra.chance_cur, card.ability.extra.chance, "kino_card_manipulation") then
                        local _seal = nil
                        if _basecard:get_seal() then seal = _basecard:get_seal() end
                        _pcard:set_seal(_seal)
                        _changes = true
                    end

                    -- enhancement check
                    if SMODS.pseudorandom_probability(card, 'kino_annihilation', card.ability.extra.chance_cur, card.ability.extra.chance, "kino_card_manipulation") then
                        _pcard:set_ability(_basecard.config.center, nil, true)
                        _changes = true
                    end

                    -- enhancement check
                    if SMODS.pseudorandom_probability(card, 'kino_annihilation', card.ability.extra.chance_cur, card.ability.extra.chance, "kino_card_manipulation") then
                        _pcard:set_edition(_basecard.edition or {}, nil, true)
                        _changes = true
                    end

                    if _changes then
                        _pcard:juice_up()
                        SMODS.calculate_effect({
                            message = localize("k_kino_annihilation"),
                            colour = G.C.LEGENDARY
                        }, card)
                    end
                end
            end
        end
    end
}