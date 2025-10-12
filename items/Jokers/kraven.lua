SMODS.Joker {
    key = "kraven",
    order = 145,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            target = nil,
            stacked_x_mult = 1,
            a_xmult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_5",
    pos = { x = 0, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 539972,
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
    k_genre = {"Superhero", "Action"},

    loc_vars = function(self, info_queue, card)
        local _cardname = "H_2"
        if card.ability.extra.target ~= nil then
            _cardname = card.ability.extra.target.config.card_key
        end

        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult,
                G.P_CARDS[_cardname].name
            }
        }
    end,
    calculate = function(self, card, context)
        -- Sets a random card in your deck to be destroyed
        -- if it's destroyed, gain X1 mult and reset
        if not card.ability.extra.target and not context.blueprint 
        and not context.repetition then
            card.ability.extra.target = pseudorandom_element(G.playing_cards)
        end

        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card.ability.extra.target then
                    card:juice_up()
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_kraven'), colour = G.C.MULT})
                    card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
                    break
                end
            end
        end
    end
}