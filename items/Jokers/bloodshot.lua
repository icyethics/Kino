SMODS.Joker {
    key = "bloodshot",
    order = 257,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 4, y = 0},
    cost = 7,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 338762,
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
    pools, k_genre = {"Sci-fi", "Superhero"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v:get_seal() == 'Red' then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If there are cards with red seals in your deck
        -- remove it from the deck and put it on the first triggering card
        -- if Active

        if context.before and context.cardarea == G.jokers and G.jokers.cards[1] == card 
        and not context.blueprint and not context.repetition then
            local _found_target = false
            for _, _pcard in ipairs(G.deck.cards) do
                if _pcard:get_seal() == 'Red' then
                    _pcard:set_seal()
                    _found_target = true
                    break
                end
            end

            if context.scoring_hand[1] and _found_target then
                context.scoring_hand[1]:set_seal("Red")
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