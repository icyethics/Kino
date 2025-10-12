SMODS.Joker {
    key = "sugarland_express",
    order = 90,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            money_stolen_non = 3,
            stacks = 0,
            a_chips = 25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 5, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 5121,
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
    k_genre = {"Crime", "Romance"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {
                card.ability.extra.money_stolen_non,
                card.ability.extra.stacks,
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- While ACTIVE, steals $3 each hand
        -- Gives +50 chips for each time it's stolen
        if context.before and context.cardarea == G.jokers and G.jokers.cards[1] ~= card then
            if to_big(G.GAME.dollars) >= to_big(G.GAME.bankrupt_at + 3) then
                ease_dollars(-1 * card.ability.extra.money_stolen_non)
                card.ability.extra.stacks = card.ability.extra.stacks + 1
                card:juice_up()
                return {
                    message = localize('k_sugarland')
                }
            end
        end

        if context.joker_main and G.jokers.cards[1] == card then
            return {
                chips = card.ability.extra.a_chips * card.ability.extra.stacks
            }
        end
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
            if not card.children.activedisplay then
                card.children.activedisplay = Kino.create_active_ui(card)
            end
        else
            card.children.activedisplay = nil
        end
        
    end,
}