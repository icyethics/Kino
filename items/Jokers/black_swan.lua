SMODS.Joker {
    key = "black_swan",
    order = 310,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            perma_mult = 5,
            cur_chance = 1,
            chance = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 3, y = 3},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 44214,
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
    pools, k_genre = {"Drama", "Horror", "Thriller"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare")
         
        return {
            vars = {
                new_numerator,
                new_denominator,
                card.ability.extra.perma_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When a Queen scores, 1/3 chance to destroy it and create a random new Queen upgraded with +5 mult
        if context.destroying_card then
            if context.destroying_card:get_id() == 12 then
                -- if pseudorandom("kino_black_swan") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
                if SMODS.pseudorandom_probability(card, 'kino_black_swan', (card.ability.extra.cur_chance), card.ability.extra.chance, "kino_jumpscare") then
                 
                    local _newcard = copy_card(context.destroying_card)
                    _newcard.ability.perma_mult = _newcard.ability.perma_mult or 0
                    _newcard.ability.perma_mult = _newcard.ability.perma_mult + card.ability.extra.perma_mult

                    _newcard:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _newcard)
                    G.deck:emplace(_newcard)
                    _newcard.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _newcard:start_materialize()
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_upgrade_ex'), 
                        colour = G.C.MULT,
                        remove = true
                    }
                end
            end
        end
    end
}