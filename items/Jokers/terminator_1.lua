SMODS.Joker {
    key = "terminator_1",
    order = 58,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 3, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 218,
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
    pools, k_genre = {"Sci-fi", "Action"},
    enhancement_gate = "m_kino_sci_fi",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                if context.removed[i].config.center == G.P_CENTERS.m_kino_sci_fi then
                    SMODS.calculate_context({sci_fi_upgrade = true, sci_fi_upgrade_target = context.removed[i]})

                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(context.removed[i], nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                    _card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_terminator_1'),
                        colour = G.C.CHIPS,
                        card = self,
                        playing_cards_created = {true}
                    }
                end
            end
        end
    end
}