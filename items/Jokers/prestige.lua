SMODS.Joker {
    key = "prestige",
    order = 103,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            increase = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_3",
    pos = { x = 0, y = 5},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1124,
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
    pools, k_genre = {"Thriller", "Drama", "Fantasy"},
    enhancement_gate = "m_lucky",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.increase
            }
        }
    end,
    calculate = function(self, card, context)
        -- when you play a hand with only a lucky card,
        -- destroy it and create a copy
        -- with all odds increased by 1

        if context.destroying_card and context.cardarea == G.play and not context.blueprint then
            if context.full_hand and #context.full_hand == 1 
            and context.full_hand[1].ability and 
            context.full_hand[1].ability.effect == "Lucky Card" then
                G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.4,
					func = function()
						card:juice_up(0.3, 0.4)
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local _c = copy_card(context.destroy_card, nil, nil, G.playing_card)
						_c:start_materialize()
						_c:add_to_deck()
                        
                        _c.ability.lucky_bonus = (_c.ability.lucky_bonus or 1) + card.ability.extra.increase
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _c)
						G.hand:emplace(_c)
						playing_card_joker_effects({ _c })
						return true
					end,
				}))

                return true
            end
        end
    end
}