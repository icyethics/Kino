SMODS.Joker {
    key = "star_wars_iii",
    order = 327,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_starwars = true,
        extra = {
            x_mult = 0.1,
            stacks = 0
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 3, y = 0},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1895,
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
    k_genre = {"Sci-fi", "Adventure"},


    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- On the first hand each round, destroy the joker to the right
        -- and upgrade every scoring card with x0.1 equal to its sell value
        if G.GAME.current_round.hands_played == 0 then

            if context.first_hand_drawn and not context.blueprint then
                local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end

            if context.before then
                if not context.blueprint and not context.repetition then
                    local my_pos = nil
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            my_pos = i
                            break
                        end
                    end
                    if my_pos and G.jokers.cards[my_pos + 1] and 
                    G.jokers.cards[my_pos + 1]:can_calculate() and 
                    not SMODS.is_eternal(G.jokers.cards[my_pos + 1], {kino_star_wars_iii = true, joker = true}) then
                        local sliced_card = G.jokers.cards[my_pos + 1]
                        card.ability.extra.stacks = sliced_card.sell_cost * card.ability.extra.x_mult
                        sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.joker_buffer = 0
                                card:juice_up(0.8, 0.8)
                                sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                                play_sound('slice1', 0.96 + math.random() * 0.08)
                                return true
                            end
                        }))
                    end
                end

                if card.ability.extra.stacks > 0 and context.scoring_hand then
                    for _index, _pcard in ipairs(context.scoring_hand) do
                        _pcard.ability.perma_x_mult = (_pcard.ability.perma_x_mult or 1) + card.ability.extra.stacks
                    end
                end
            end

            if context.after then
                card.ability.extra.stacks = 0
            end
        end
    end
}