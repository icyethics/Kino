SMODS.Joker {
    key = "edward_scissorhands",
    order = 51,
    config = {
        extra = {
        }
    },
    rarity = 2,
    atlas = "kino_atlas_2",
    pos = { x = 2, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 162,
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
    pools, k_genre = {"Fantasy", "Romance"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If your first played hand of the round is only a single high card,
        -- cut it in half after scoring.

        if context.joker_main and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 then
            if context.full_hand and #context.full_hand == 1 then
                context.full_hand[1].marked_to_be_destroyed_by_scissorhands = true
            end
        end

        if context.destroying_card and context.destroy_card.marked_to_be_destroyed_by_scissorhands then
            local _suit = string.sub(context.destroying_card.base.suit, 1, 1).."_"
            local _rank = math.floor(context.destroying_card.base.id / 2, 2)
            local _uneven = false
            local _enhancement = context.destroying_card.config.center
            local _seal = context.destroying_card.seal

            if (context.destroying_card.base.id / 2 ) % 1 == 0.5 then
                _uneven = true
            end
            for i = 1, 2 do
                local _fullrank = _rank
                if _uneven then
                    if i == 1 then
                        _fullrank = _rank + 1
                    end
                end

                G.E_MANAGER:add_event(Event({
                    func = function() 

                        local _card = create_playing_card({
                            front = G.P_CARDS[_suit .. _fullrank], 
                            center = _enhancement}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        
                        if context.destroying_card.edition then
                            _card:set_edition(context.destroying_card.edition.key, true, nil, true)
                            
                        end
                        _card:set_seal(context.destroying_card.seal, true)
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        return true
                    end}))

            end

            return true
        end
    end
}