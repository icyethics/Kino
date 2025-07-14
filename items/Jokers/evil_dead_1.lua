SMODS.Joker {
    key = "evil_dead_1",
    order = 176,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_chance = 1,
            chance = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 1, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 109428,
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
    pools, k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.cur_chance, card.ability.extra.chance, "kino_card_generation")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    calculate = function(self, card, context)
        -- New Effect: When you sacrifice a card, 1/3 chance to return it as a demon card to your hand
        if context.kino_sacrifices then
            local _returnedCards = {}

            for _, _card in ipairs(context.kino_sacrificed_cards) do
                -- if pseudorandom("kino_evil_dead_1") < (card.ability.extra.cur_chance) / card.ability.extra.chance then
                if SMODS.pseudorandom_probability(card, 'kino_evil_dead_1', card.ability.extra.cur_chance, card.ability.extra.chance, "kino_card_generation") then
                    _returnedCards[#_returnedCards + 1] = _card
                end    
            end
            -- Return each card to hand
            for _, _pcard in ipairs(_returnedCards) do
                local _newcard = copy_card(_pcard)
                _newcard:set_ability("m_kino_demonic")
                _newcard.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        _newcard:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _newcard)
                        G.hand:emplace(_newcard)
                        _newcard:start_materialize()
                        return true
                    end
                }))
            end 
            if #_returnedCards > 1 then
                return {
                    message = localize('k_kino_evil_dead_1'), 
                }
            end
        end
    end
}