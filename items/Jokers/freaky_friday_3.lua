SMODS.Joker {
    key = "freaky_friday_3",
    order = 248,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 3, y = 3},
    cost = 6,
    blueprint_compat = false,
    perishable_compat = false,
    kino_joker = {
        id = 10330,
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
    pools, k_genre = {"Comedy", "Family", "Fantasy"},
    set_ability = function(self, card, initial, delay_sprites)
        if card.area and card.area.config.collection then

        else
            local edition = poll_edition('freaky_friday_3', nil, true, true)
            card:set_edition({foil = true}, true)
        end
        
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When a card with an edition triggers, it loses that edition and this card gets it
        -- 
        if context.individual and context.cardarea == G.play and G.jokers.cards[1] == card 
        and not context.blueprint and not context.repetition then
            if card.edition == nil and context.other_card.edition ~= nil then
                card:set_edition(context.other_card.edition or {}, nil, true)
                context.other_card:set_edition(nil, true)
            elseif card.edition ~= nil and  context.other_card.edition == nil then
                context.other_card:set_edition(card.edition or {}, nil, true)
                card:set_edition(nil, true)
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