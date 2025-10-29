SMODS.Joker {
    key = "x",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cards_drawn = 4,
            cards_destroyed_non = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_11",
    pos = { x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 760104,
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
    k_genre = {"Horror"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {
                card.ability.extra.cards_drawn,
                card.ability.extra.cards_destroyed_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- When active, draw an additional 4 cards on your opening hand, but destroy a random card
        if context.first_hand_drawn and G.jokers.cards[1] == card then
            if #context.hand_drawn >= 1 then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    card:juice_up()

                    G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards_drawn)
                    delay(0.23)
                return true end }))
                
                
                local _viable_targets = {}
                for _index, _pcard in ipairs(context.hand_drawn) do
                    if _pcard:can_calculate() then
                        _viable_targets[#_viable_targets + 1] = _pcard
                    end
                end

                local _target = pseudorandom_element(_viable_targets, pseudoseed("k_kino_x"))

                if _target and _target:can_calculate() then
                    SMODS.destroy_cards(_target)
                end
            end
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