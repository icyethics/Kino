SMODS.Joker {
    key = "resident_evil",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_8",
    pos = { x = 4, y = 4},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1576,
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
    k_genre = {"Horror", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- If you discard a single card
        -- destroy every card with the same rank held in hand
        if context.discard and context.cardarea == G.jokers
        and #context.full_hand == 1 and 
        not context.blueprint and not context.retrigger_joker then
            for _index, _pcard in ipairs(G.hand.cards) do
                if _pcard:get_id() == context.full_hand[1]:get_id() 
                and _pcard ~= context.full_hand[1] then
                    SMODS.destroy_cards(_pcard)
                end
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'discard_custom' and #args.cards >= 5 then
            local _card_id_1
            local _tally = 0
            local _card_id_2
            local _tally_2 = 0
            for j = 1, #args.cards do
                if _card_id_2 and _card_id_2 == args.cards[j]:get_id() then
                    _tally = _tally + 1
                end
                if _card_id_1 and not _card_id_2 then 
                    _card_id_2 = args.cards[j]:get_id()
                    _tally_2 = _tally_2 + 1
                end

                if _card_id_1 and _card_id_1 == args.cards[j]:get_id() then
                    _tally = _tally + 1
                end
                if not _card_id_1 then 
                    _card_id_1 = args.cards[j]:get_id()
                    _tally = _tally + 1
                end
            end

            if _tally >= 4 or _tally_2 >= 4 then
                unlock_card(self)
            end
        end
    end,
}