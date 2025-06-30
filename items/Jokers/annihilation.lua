SMODS.Joker {
    key = "annihilation",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
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
        return {
            vars = {
                (G.GAME.probabilities.normal * card.ability.extra.cur_chance),
                card.ability.extra.chance
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
                    if pseudorandom("kino_annihilation") < ((G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance) then
                        SMODS.modify_rank(_pcard, nil, _basecard:get_id())
                        _changes = true
                    end

                    -- suit check
                    if pseudorandom("kino_annihilation") < ((G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance) then
                        SMODS.change_base(_pcard, _basecard.base.suit)
                        _changes = true
                    end

                    -- seal check
                    if pseudorandom("kino_annihilation") < ((G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance) then
                        local _seal = nil
                        if _basecard:get_seal() then seal = _basecard:get_seal() end
                        _pcard:set_seal(_seal)
                        _changes = true
                    end

                    -- enhancement check
                    if pseudorandom("kino_annihilation") < ((G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance) then
                        _pcard:set_ability(_basecard.config.center, nil, true)
                        _changes = true
                    end

                    -- enhancement check
                    if pseudorandom("kino_annihilation") < ((G.GAME.probabilities.normal * card.ability.extra.cur_chance) / card.ability.extra.chance) then
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