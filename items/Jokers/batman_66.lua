SMODS.Joker {
    key = "batman_66",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            cards_created = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 2, y = 2},
    cost = 6.6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 2661,
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
    k_genre = {"Superhero", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_created
            }
        }
    end,
    calculate = function(self, card, context)
        -- create a consumable when a blind is selected
        -- if it's a boss blind, create a batman joker instead
        -- (must have room)
        if context.setting_blind then
            if G.GAME.blind.boss and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local _jokers_to_create = math.min(card.ability.extra.cards_created, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + _jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _ = 1, _jokers_to_create do
                            SMODS.add_card {
                                set = 'kino_batman',
                                key_append = 'kino_batman66'
                            }
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            elseif #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                local _jokers_to_create = math.min(card.ability.extra.cards_created, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + _jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _ = 1, _jokers_to_create do
                            SMODS.add_card {
                                set = 'Tarot',
                                key_append = 'kino_batman66'
                            }
                            G.GAME.consumeable_buffer = 0
                        end
                        return true
                    end
                }))
            end
        end
    end
}