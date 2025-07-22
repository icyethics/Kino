SMODS.Joker {
    key = "rogue_one",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 3, y = 1},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 330459,
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
    pools = {["kino_starwars"] = true}, 
    k_genre = {"Sci-fi", "Action"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_death_star
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When a joker is destroyed, create a Death Star
        if context.joker_type_destroyed then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = SMODS.create_card({type = "planet", area = G.consumeables, key = "c_kino_death_star", no_edition = true})
                            _card:add_to_deck()
                            G.consumeables:emplace(_card) 
                            return true
                        end}))
                        card:juice_up()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.PURPLE})
                end
            
        end
    end
}